extends Node2D




@onready var server_list = $"Server-List"
@onready var main_server = $"Server-List/Main-Server"
@onready var server_scroll_pagination = $Server_Pagination_Scroll


var self_server_address



@onready var refreshing = $Refresh


@onready var camera_view = $CameraView


@onready var api = $APIRequest
var json = JSON.new()
var serverslink = "http://31.129.54.119/servers"


var token = JSON.stringify({
		"token":GLOBAL.from_auth_token
	})



func _process(_delta):
	server_list.position.y = server_scroll_pagination.value





func _ready():
	api.request(serverslink, [], HTTPClient.METHOD_GET, token)




func _on_api_request_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	var message = str(api_response["message"])
	#var servers = api_response["servers"]
	var servers = [
		
	 { "id": 1, "address": "31.129.54.121", "name": "#1 Alpha", "locale": "RU", "max_players": 1000, "status": "active", "create_date": "04/08/2024 19:00:22" },
	 { "id": 2, "address": "31.129.54.121", "name": "#2 Alpha", "locale": "RU", "max_players": 1000, "status": "active", "create_date": "04/08/2024 19:00:22" },
	 { "id": 3, "address": "31.129.54.122221", "name": "#3 Alpha", "locale": "RU", "max_players": 1000, "status": "active", "create_date": "04/08/2024 19:00:22" }]
	
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
				
				
				if !new_server_play_button.is_connected("pressed", _on_play_button_pressed):
					new_server_play_button.connect("pressed", _on_play_button_pressed)
				
				
				
				
				
		if server_id > 8:
			server_scroll_pagination.visible = true
		else:
			server_scroll_pagination.visible = false




func _on_back_button_pressed():
	GLOBAL.sign_out = true
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")




func _on_play_button_pressed():
	print("Выбран сервер: " + GLOBAL.choiced_server_address)
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")





