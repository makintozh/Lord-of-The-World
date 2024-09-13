extends Control



var label_style = load("res://src/ui/tres/server_label_texture.tres")
var button_style = load("res://src/ui/tres/server_button_texture.tres")


@onready var server_list = $"ScrollContainer/Server-List"

@onready var refreshing = $Refresh

@onready var api = $APIRequest

var json = JSON.new()

var server_massive = []






var token = JSON.stringify({
	
		"token":GLOBAL.from_auth_token
		
	})


var bearer_header = ["Authorization: Bearer " + GLOBAL.from_auth_token]


func _ready():
	print(bearer_header)
	api.request(CONFIG.api_link + "/servers", bearer_header, HTTPClient.METHOD_GET)
	after_remember_me()



func _on_api_request_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	var message = str(api_response["message"])
	var servers = api_response["servers"]
	
	
	
	
	parse_json(str(api_response))
	refreshing.visible = false







func parse_json(json_string: String):
	var result = JSON.parse_string(json_string)
	server_massive = result["servers"]
	print(str(server_massive))
	create_server_buttons()



func create_server_buttons():
	
	for server in server_massive:
		
		
		var play_button = Button.new()
		play_button.add_theme_stylebox_override("normal", button_style)
		play_button.add_theme_stylebox_override("focus", button_style)
		play_button.add_theme_stylebox_override("hover", button_style)
		play_button.add_theme_stylebox_override("pressed", button_style)
		play_button.add_theme_font_size_override("font_size" , 21)
		play_button.mouse_filter = Control.MOUSE_FILTER_PASS
		play_button.z_index = 2
		play_button.position.x = 330
		play_button.position.y = -5
		play_button.size.x = -10
		play_button.size.y = 50
		
		play_button.text = "Play"
		play_button.pressed.connect(self._on_play_button_pressed.bind(server["name"],server["address"]))
		
		
		
		
		var server_name_label = Label.new()
		server_name_label.add_theme_font_size_override("font_size" , 31)
		#server_name_label.add_theme_stylebox_override("normal", label_style)
		#server_name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		server_name_label.z_index = 3


		server_name_label.text = "          " + server.name
		
		var hbox = HBoxContainer.new()
		hbox.add_theme_constant_override("separation" , 0)
		
		
		
		
		var locale_icon_RU = TextureRect.new()
		locale_icon_RU.set_texture(load("res://src/ui/elements/Group 1000006717.png"))
		locale_icon_RU.z_index = 1
		locale_icon_RU.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		locale_icon_RU.stretch_mode = TextureRect.STRETCH_SCALE
		locale_icon_RU.position.x = 40
		locale_icon_RU.size.y = 37
		
		server_list.add_child(hbox)
		
		
		var server_background = TextureRect.new()
		server_background.set_texture(load("res://src/ui/buttons/button_2.png"))
		server_background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		server_background.size.x = 450
		server_background.size.y = 80
		server_background.z_index = 0
		server_background.z_as_relative = false
		
		
		server_background.duplicate(server.id + 1)
		
		for i in range(server.id + 1):
			server_background.position.x = 20
			server_background.position.y = -20
		
		server_name_label.add_child(server_background)
		server_name_label.add_child(locale_icon_RU)

		

		
		#hbox.add_child(locale_icon_RU)
		hbox.add_child(server_name_label)
		server_name_label.add_child(play_button)
		




func _on_play_button_pressed(name: String, address: String):
	GLOBAL.choiced_server_name = name
	GLOBAL.choiced_server_address = address
	print("\nВыбрано: " + GLOBAL.choiced_server_name + " " + str(GLOBAL.choiced_server_address))
	SceneManager.go_to_scene("res://src/scenes/game-scenes/character_create.tscn")
	remember_me()









func _on_back_button_pressed():
	if not GLOBAL.from_change_server:
		GLOBAL.sign_out = true
		SceneManager.go_to_scene("res://src/scenes/auth-scenes/login_ui.tscn")
	else:
		SceneManager.go_to_scene("res://src/scenes/game-scenes/character_create.tscn")





var data = ConfigFile.new()
var data_path = "user://server_data.cfg"
var data_name = "SERVER DATA"

var data_server_ip = "server_ip"
var data_server_name = "server_name"



func remember_me():
	if GLOBAL.is_remember:
		var server_ip = GLOBAL.choiced_server_address
		var server_name = GLOBAL.choiced_server_name
		data.set_value(data_name, "server_ip", server_ip)
		data.set_value(data_name, "server_name", server_name)
		data.save_encrypted_pass(data_path, "makintosh")
		print("Saved: " + server_ip + "  |||  " + server_name)






func after_remember_me():
	if FileAccess.file_exists(data_path) and GLOBAL.from_change_server == false:
		data.load_encrypted_pass(data_path, "makintosh")
		print("Data Exists " + data_path)
		var server_ip = data.get_value(data_name, data_server_ip, "")
		var server_name = data.get_value(data_name, data_server_name, "")
		print("Loading data: " + server_ip + "  |||  " + server_name)
		_on_play_button_pressed(server_name , server_ip)
