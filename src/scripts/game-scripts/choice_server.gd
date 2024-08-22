extends Control



var label_style = load("res://src/ui/tres/server_label_texture.tres")
var button_style = load("res://src/ui/tres/server_button_texture.tres")



@onready var server_list = $"ScrollContainer/Server-List"
@onready var server_control = $"ScrollContainer/Server-List/Server"

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
	api.request(CONFIG.api_link + "/servers", bearer_header, HTTPClient.METHOD_GET, token)




func _on_api_request_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	var message = str(api_response["message"])
	var servers = api_response["servers"]
	
	
	
	
	parse_json(str(api_response))
	refreshing.visible = false







func parse_json(json_string: String):
	var result = JSON.parse_string(json_string)
	server_massive = result["servers"]
	print(server_massive)
	create_server_buttons()



func create_server_buttons():
	
	for server in server_massive:
		
		
		var play_button = Button.new()
		play_button.add_theme_stylebox_override("normal", button_style)
		play_button.add_theme_stylebox_override("focus", button_style)
		play_button.add_theme_stylebox_override("hover", button_style)
		play_button.add_theme_stylebox_override("pressed", button_style)
		play_button.add_theme_font_size_override("font_size" , 21)
		
		play_button.text = "Play"
		play_button.pressed.connect(self._on_play_button_pressed.bind(server["name"],server["address"]))
		
		
		
		
		var server_name_label = Label.new()
		server_name_label.add_theme_font_size_override("font_size" , 41)
		server_name_label.add_theme_stylebox_override("normal", label_style)
		
		server_name_label.text = server.name
		
		server_list.add_child(server_name_label)
		server_list.add_child(play_button)
		
		






func _on_play_button_pressed(name: String, address: String):
	GLOBAL.choiced_server_name = name
	GLOBAL.choiced_server_address = address
	print("\nВыбрано: " + GLOBAL.choiced_server_name + " " + str(GLOBAL.choiced_server_address))
	SceneManager.go_to_scene("res://src/scenes/game-scenes/character_create.tscn")










func _on_back_button_pressed():
	if not GLOBAL.from_change_server:
		GLOBAL.sign_out = true
		SceneManager.go_to_scene("res://src/scenes/auth-scenes/login_ui.tscn")
	else:
		SceneManager.go_to_scene("res://src/scenes/game-scenes/character_create.tscn")
