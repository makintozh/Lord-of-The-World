extends Control




@onready var server_list = $"Server-List"
@onready var main_server = $"Server-List/Main-Server"
@onready var server_scroll_pagination = $Server_Pagination_Scroll


var self_server_address



@onready var refreshing = $Refresh




@onready var api = $APIRequest
var json = JSON.new()


var token = JSON.stringify({
		"token":GLOBAL.from_auth_token
	})



func _process(_delta):
	server_list.position.y = server_scroll_pagination.value





func _ready():
	api.request(CONFIG.api_link + "/servers", CONFIG.api_headers, HTTPClient.METHOD_GET, token)




func _on_api_request_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	var message = str(api_response["message"])
	var servers = api_response["servers"]
	#var servers = [
		#
	 #{ "id": 1, "address": "31.111.54.111", "name": "#1 Alpha", "locale": "RU", "max_players": 1000, "status": "active", "create_date": "04/08/2024 19:00:22" },
	 #{ "id": 2, "address": "31.222.54.222", "name": "#2 Alpha", "locale": "RU", "max_players": 1000, "status": "active", "create_date": "04/08/2024 19:00:22" },
	 #{ "id": 3, "address": "31.333.54.333", "name": "#3 Alpha", "locale": "RU", "max_players": 1000, "status": "active", "create_date": "04/08/2024 19:00:22" }]
	
	print("\nСообщение: " + message)
	print("\nВсе Сервера в JSON: " + str(servers))
	
	
	refreshing.visible = false


	for data in servers:
		var server_id = int(data["id"])
		var server_name =str(data["name"])
		var server_locale = str(data["locale"])
		var server_address = str(data["address"])
		var server_max_players = int(data["max_players"])
		var server_status = str(data["status"])
		var server_create_date = str(data["create_date"])



		print("Айди Сервера: " + str(server_id) + "  |||  Имя сервера: " + server_name + " (" + server_status + ")  |||  Язык: " + server_locale + "  |||  Адрес: " + server_address)
		
		
		if server_id >= 1:
			main_server.queue_free()
			var new_servers = main_server.duplicate(server_id)
			server_list.add_child(new_servers)
			new_servers.position.y = -129
			new_servers.visible = true
			
			
			
			
			
			for amount in server_id:
				server_scroll_pagination.min_value = amount - amount**2.42
				server_scroll_pagination.max_value = 0
				new_servers.position.y += 100
				var new_server_name_label = new_servers.get_child(2).get_children()[0]
				var new_server_play_button = new_servers.get_child(3).get_children()[0]
				new_server_name_label.text = server_name
				

				
				if !new_server_play_button.is_connected("pressed", play):
					new_server_play_button.connect("pressed", play)
					
					
				
				
				
		if server_id > 8:
			server_scroll_pagination.visible = true
		else:
			server_scroll_pagination.visible = false




func _on_back_button_pressed():
	GLOBAL.sign_out = true
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")


func play():
	#print("Выбран сервер: " + GLOBAL.choiced_server_address)
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")







