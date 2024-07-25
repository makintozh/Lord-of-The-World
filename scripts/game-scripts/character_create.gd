extends Node2D



@onready var characternameinput = $CharacterName/CharacterNameContainer/CharacterNameInput
@onready var charactercreatebutton = $CharacterCreateButton/CharacterCreateButtonContainer/CharacterCreateButton
@onready var characterfeaturename = $CharacterFeature/CharacterFeatureName/CharacterFeatureName
@onready var charactertypename = $CharacterTypeName/CharacterTypeName/CharacterTypeName
@onready var elvestype = $CharacterTypeChoice/ElvesType
@onready var dwarfstype = $CharacterTypeChoice/DwarfsType
@onready var humanstype = $CharacterTypeChoice/HumansType
@onready var agilityfeature = $FeatureScheme/AgilityFeatureScheme
@onready var strengthfeature = $FeatureScheme/StrengthFeatureScheme
@onready var intelligencefeature = $FeatureScheme/IntelligenceFeatureScheme







func _process(delta):
	current_character()
	checkcharacternameinput()





func checkcharacternameinput():
	if characternameinput.text.is_empty():
		disable_create()
	else:
		enable_create()



func current_character():
	
	if GLOBAL.character_index > 1:
		GLOBAL.character_index = 1
	elif GLOBAL.character_index < -1:
		GLOBAL.character_index = -1
		
	if GLOBAL.character_index == 0:
		characterfeaturename.text = "Agility"
		charactertypename.text = "Elves"
		agilityfeature.visible = true
		strengthfeature.visible = false
		intelligencefeature.visible = false
		elvestype.position.x = 170
		elvestype.position.y = 101
		elvestype.size.x = 148
		elvestype.size.y = 140
		dwarfstype.position.x = 331
		dwarfstype.position.y = 115
		dwarfstype.size.x = 121
		dwarfstype.size.y = 116
		humanstype.position.x = 40
		humanstype.position.y = 115
		humanstype.size.x = 121
		humanstype.size.y = 116
		
	elif GLOBAL.character_index == 1:
		characterfeaturename.text = "Strength"
		charactertypename.text = "Dwarfs"
		agilityfeature.visible = false
		strengthfeature.visible = true
		intelligencefeature.visible = false
		elvestype.position.x = 331
		elvestype.position.y = 115
		elvestype.size.x = 121
		elvestype.size.y = 116
		dwarfstype.position.x = 170
		dwarfstype.position.y = 101
		dwarfstype.size.x = 148
		dwarfstype.size.y = 140
		humanstype.position.x = 40
		humanstype.position.y = 115
		humanstype.size.x = 121
		humanstype.size.y = 116
		
	elif GLOBAL.character_index == -1:
		characterfeaturename.text = "Intelligence"
		charactertypename.text = "Humans"
		agilityfeature.visible = false
		strengthfeature.visible = false
		intelligencefeature.visible = true
		elvestype.position.x = 40
		elvestype.position.y = 115
		elvestype.size.x = 121
		elvestype.size.y = 116
		dwarfstype.position.x = 331
		dwarfstype.position.y = 115
		dwarfstype.size.x = 121
		dwarfstype.size.y = 116
		humanstype.position.x = 170
		humanstype.position.y = 101
		humanstype.size.x = 148
		humanstype.size.y = 140






func disable_create():
	charactercreatebutton.modulate = "ffffff78"
	charactercreatebutton.disabled = true
	
func enable_create():
	charactercreatebutton.modulate = "ffffffff"
	charactercreatebutton.disabled = false




func _on_character_create_button_pressed():
	GLOBAL.player_character_name = characternameinput.text
	get_tree().change_scene_to_file("res://scenes/game-scenes/navigation-menu.tscn")




func _on_right_choice_button_pressed():
	GLOBAL.character_index += 1





func _on_left_choice_button_pressed():
	GLOBAL.character_index -= 1





