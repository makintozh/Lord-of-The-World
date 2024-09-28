extends Control




@onready var main_ui = $MainUI
@onready var player_character_name = $MainUI/PlayerCharacterName/CharacterNameContainer/CharacterNameInput
@onready var charactercreatebutton = $MainUI/CharacterCreateButton/CharacterCreateButtonContainer/CharacterCreateButton
@onready var archetype = $MainUI/Archetype/Archetype/Archetype
@onready var character_name = $MainUI/CharacterName/CharacterName/CharacterName


@onready var api_character = $APICharacterCreate


@onready var refreshing = $Refresh





var token = JSON.stringify({
		
		"token":GLOBAL.from_auth_token
		
		})


var bearer_header = ["Authorization: Bearer " + GLOBAL.from_auth_token]





func _ready():
	print(token)
	print(bearer_header)





func _on_character_create_button_pressed(): 
	var character_data = JSON.stringify({
  "name": "string",
  "avatar": "#",
  "race_id": 1,
  "class_id": 1,
  "subclass_id": 1,
  "character_type": "string",
  "summand_params": {
	"damage": 10,
	"vitality": 10,
	"speed": 10,
	"resistance": 10,
	"evasion": 10
  },
  "multiplier_params": {
	"damage": 1,
	"vitality": 1,
	"speed": 1,
	"resistance": 1,
	"evasion": 1
  },
  "item_ids": [],
  "ability_ids": [],
  "stardom": 0,
  "level": 0
})
		
		
	print(character_data)
	print("http://" + GLOBAL.choiced_server_address + "/game_logic/characters")
	api_character.request("http://" + GLOBAL.choiced_server_address + "/game_logic/characters", bearer_header, HTTPClient.METHOD_POST, character_data)







func _on_api_character_create_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	
	print(api_response)
	print(str(response_code))
	
	
	#if response_code == 200:
	SceneManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")
	refreshing.visible = false
	#else:
		#printerr("Token is invalid on Character Create")
		#push_error("Token is invalid on Character Create")
		#SceneManager.exit_app("/createcharacter token error")








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










func adaptive_keyboard():
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		var height = DisplayServer.virtual_keyboard_get_height()
		main_ui.offset.y = -height/CONFIG.adaptive_keyboard_pixel   






func _process(_delta):                                                                                                                                                                                                   
	check_player_character_name()
	adaptive_keyboard()






func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/auth-scenes/choice_server.tscn")
