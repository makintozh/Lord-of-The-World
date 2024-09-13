extends Control




@onready var main_ui = $MainUI
@onready var player_character_name = $MainUI/PlayerCharacterName/CharacterNameContainer/CharacterNameInput
@onready var charactercreatebutton = $MainUI/CharacterCreateButton/CharacterCreateButtonContainer/CharacterCreateButton
@onready var archetype = $MainUI/Archetype/Archetype/Archetype
@onready var character_name = $MainUI/CharacterName/CharacterName/CharacterName


@onready var api = $APIRequest
@onready var api_character = $APICharacterCreate
@onready var api_summary = $APISummary


@onready var refreshing = $Refresh



var current_index:int = 0
var archetypes = {}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
var archetype_id
var archetype_title


var token = JSON.stringify({
		
		"token":GLOBAL.from_auth_token
		
		})


var bearer_header = ["Authorization: Bearer " + GLOBAL.from_auth_token]





func _ready():
	print(token)
	print(bearer_header)
	
	main_ui.visible = false
	api_summary.request("http://" + GLOBAL.choiced_server_address + "/summary", bearer_header, HTTPClient.METHOD_GET)
	await get_tree().create_timer(0.3).timeout
	api.request("http://" + GLOBAL.choiced_server_address + "/archetypes", bearer_header, HTTPClient.METHOD_GET)
	






func _on_character_create_button_pressed(): 
	var character_data = JSON.stringify({
		
		"name":player_character_name.text,
		"archetype_id":current_index + 1 
		
		})
		
		
	print(character_data)
	api_character.request("http://" + GLOBAL.choiced_server_address + "/create_character", bearer_header, HTTPClient.METHOD_POST, character_data)




func _on_api_request_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	await get_tree().create_timer(0.3).timeout
	var message = str(api_response["message"])
	archetypes = api_response["archetypes"]
	
	
	#archetypes = [
		#{
			#"id":1,
			#"title": "Strength"
		#}
	#]
	
	
	print(str(result))
	print("\nСообщение: " + message)
	print("\nАрхетипы: " + str(archetypes))
	
	
	if archetypes == []:
		printerr("Нет архетипов на сервере!")
		
		
	for data in archetypes:
		archetype_id = str(data["id"])
		archetype_title = str(data["title"])
		print(archetype_id)
		print(archetype_title)
		print("size: " + str(archetypes.size()))
		
		archetype.text = archetypes[0]["title"]
		
		

	if message == "Token is invalid!":
		push_error("/archetype token error")
		printerr("/archetype token error")
		SceneManager.exit_app("/arch token error")



func _on_api_character_create_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	var message = str(api_response["message"])
	
	print(api_response)
	print(str(response_code))
	print(message)
	
	
	if response_code == 200 and message != "Token is invalid":
		SceneManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")
		refreshing.visible = false
	else:
		printerr("Token is invalid on Character Create")
		push_error("Token is invalid on Character Create")
		SceneManager.exit_app("/createcharacter token error")




func _on_api_summary_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	var message = api_response["message"]
	var character_info = api_response["character_info"]
	
	print(api_response)
	print("\nCharacter Info: " + str(character_info))
	
	
	
	
	if str(character_info) != "<null>":
		var name = str(character_info["name"])
		GLOBAL.player_character_name = name
		SceneManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")
	else:
		refreshing.visible = false
		main_ui.visible = true



	if message == "Token is invalid!":
		push_error("/summary token error")
		printerr("/summary token error")
		SceneManager.exit_app("/summ token error")





func check_player_character_name():
	if player_character_name.text.is_empty():
		disable_create()
	else:
		enable_create()




func disable_create():
	charactercreatebutton.modulate = GLOBAL.disable_button_transparent
	charactercreatebutton.disabled = true
	
func enable_create():
	charactercreatebutton.modulate = GLOBAL.enable_button_transparent
	charactercreatebutton.disabled = false




func _on_right_button_pressed():
	current_index += 1
	update()

func _on_left_button_pressed():
	current_index -= 1
	update()


func update():
	check_index_valid()
	archetype.text = archetypes[current_index]["title"]
	


func check_index_valid():
	if current_index >= archetypes.size():
		current_index = 0
		
	elif current_index < 0:
		current_index = archetypes.size() - 1
		
	elif current_index > archetypes.size() - 1:
		current_index = 0
		
	elif current_index == archetypes.size():
		current_index -= 1
		
	print(current_index)






func adaptive_keyboard():
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		var height = DisplayServer.virtual_keyboard_get_height()
		main_ui.offset.y = -height/CONFIG.adaptive_keyboard_pixel   






func _process(_delta):                                                                                                                                                                                                   
	check_player_character_name()
	adaptive_keyboard()






func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/auth-scenes/choice_server.tscn")
