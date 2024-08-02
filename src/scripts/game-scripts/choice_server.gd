extends Node2D

@onready var server_1 = $"#1 Server"
@onready var server_2 = $"#2 Server"
@onready var server_3 = $"#3 Server"

@onready var server_1_name_label = $"#1 Server/ServarNameContainer/ServerName"
@onready var server_2_name_label = $"#2 Server/ServarNameContainer/ServerName"
@onready var server_3_name_label = $"#3 Server/ServarNameContainer/ServerName"


@onready var refreshing = $Refresh


@onready var api = $APIRequest
var json = JSON.new()
var serverslink = "http://31.129.54.119/servers"



var token = JSON.stringify({
		"token":GLOBAL.from_auth_token
	})





func _ready():
	api.request(serverslink, [], HTTPClient.METHOD_GET, token)





func _on_api_request_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	var message = str(api_response["message"])
	var servers = api_response["servers"] 
	print("\nВсе Сервера в JSON:" + str(servers[0]))
	
	refreshing.visible = false

	for data in servers:
		var server_id = str(data["id"])
		var server_name =str(data["name"])
		var server_locale = str(data["locale"])
		var server_address = str(data["address"])
		
		for index in server_id:
			if "1" in index:
				server_1.visible = true
				server_1_name_label.text = server_name
			elif "2" in index:
				server_2.visible = true
				server_2_name_label.text = server_name
			elif "3" in index:
				server_3.visible = true
				server_3_name_label.text = server_name
			else:
				printerr("Ошибка сервера")






























func _on_back_button_pressed():
	GLOBAL.sign_out = true
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")










