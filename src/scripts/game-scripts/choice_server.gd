extends Node2D

@onready var server_1 = $"Server-List/#1 Server"
@onready var server_2 = $"Server-List/#2 Server"
@onready var server_3 = $"Server-List/#3 Server"
@onready var server_4 = $"Server-List/#4 Server"
@onready var server_5 = $"Server-List/#5 Server"
@onready var server_6 = $"Server-List/#6 Server"


@onready var server_1_name_label = $"Server-List/#1 Server/ServarNameContainer/ServerName"
@onready var server_2_name_label = $"Server-List/#2 Server/ServarNameContainer/ServerName"
@onready var server_3_name_label = $"Server-List/#3 Server/ServarNameContainer/ServerName"
@onready var server_4_name_label = $"Server-List/#4 Server/ServarNameContainer/ServerName"
@onready var server_5_name_label = $"Server-List/#5 Server/ServarNameContainer/ServerName"
@onready var server_6_name_label = $"Server-List/#6 Server/ServarNameContainer/ServerName"


var server_1_address = null
var server_2_address = null
var server_3_address = null
var server_4_address = null
var server_5_address = null
var server_6_address = null


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
	
	
	print("\nВсе Сервера в JSON: " + str(servers))
	
	
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
				server_1_address = server_address
				print(server_name)
				print(server_address)
				
			elif "2" in index:
				server_2.visible = true
				server_2_name_label.text = server_name
				server_2_address = server_address
				print(server_name)
				print(server_address)
				
			elif "3" in index:
				server_3.visible = true
				server_3_name_label.text = server_name
				server_3_address = server_address
				print(server_name)
				print(server_address)
				
			elif "4" in index:
				server_4.visible = true
				server_4_name_label.text = server_name
				server_4_address = server_address
				print(server_name)
				print(server_address)
				
			elif "5" in index:
				server_5.visible = true
				server_5_name_label.text = server_name
				server_5_address = server_address
				print(server_name)
				print(server_address)
				
			elif "6" in index:
				server_6.visible = true
				server_6_name_label.text = server_name
				server_6_address = server_address
				print(server_name)
				print(server_address)
				
			else:
				printerr("Ошибка сервера")



















func _on_back_button_pressed():
	GLOBAL.sign_out = true
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")




func _on_play_button_1_server_pressed():
	GLOBAL.choiced_server_address = server_1_address
	print("Выбран сервер: " + GLOBAL.choiced_server_address)
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")


func _on_play_button_2_server_pressed():
	GLOBAL.choiced_server_address = server_2_address
	print("Выбран сервер: " + GLOBAL.choiced_server_address)
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")


func _on_play_button_3_server_pressed():
	GLOBAL.choiced_server_address = server_3_address
	print("Выбран сервер: " + GLOBAL.choiced_server_address)
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")


func _on_play_button_4_server_pressed():
	GLOBAL.choiced_server_address = server_4_address
	print("Выбран сервер: " + GLOBAL.choiced_server_address)
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")


func _on_play_button_5_server_pressed():
	GLOBAL.choiced_server_address = server_5_address
	print("Выбран сервер: " + GLOBAL.choiced_server_address)
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")


func _on_play_button_6_server_pressed():
	GLOBAL.choiced_server_address = server_6_address
	print("Выбран сервер: " + GLOBAL.choiced_server_address)
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")


















