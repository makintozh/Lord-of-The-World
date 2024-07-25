extends Node2D



@onready var characternameinput = $CharacterName/CharacterNameContainer/CharacterNameInput
@onready var charactercreatebutton = $CharacterCreateButton/CharacterCreateButtonContainer/CharacterCreateButton
@onready var characterfeaturename = $CharacterFeature/CharacterFeatureName/CharacterFeatureName
@onready var charactertypename = $CharacterTypeName/CharacterTypeName/CharacterTypeName
@onready var elves = $CharacterChoiceCanvas/Characters/Elves
@onready var dwarfs = $CharacterChoiceCanvas/Characters/Dwarfs
@onready var humans = $CharacterChoiceCanvas/Characters/Humans
@onready var agilityfeature = $FeatureScheme/AgilityFeatureScheme
@onready var strengthfeature = $FeatureScheme/StrengthFeatureScheme
@onready var intelligencefeature = $FeatureScheme/IntelligenceFeatureScheme


var animation_duration:float = 0.09
var other_character_position_y = 115
var current_character_position_y = 101
var current_character_position_x = 170
var right_character_position_x = 40
var left_character_position_x = 331
var current_character_size_x = 148
var current_character_size_y = 140
var other_character_size_x = 121
var other_character_size_y = 116
var current_character_transparent = "ffffffff"
var other_character_transparent = "ffffff78"
var current_character_name:String = "undefined"
var start_index:int = 0
var max_index:int = 1
var min_index:int = -1




func _process(_delta):
	current_character()
	checkcharacternameinput()





func checkcharacternameinput():
	if characternameinput.text.is_empty():
		disable_create()
	else:
		enable_create()



func current_character():
	
	if GLOBAL.character_index > max_index:
		GLOBAL.character_index = min_index
	elif GLOBAL.character_index < min_index:
		GLOBAL.character_index = max_index
		
		
		
		
	if GLOBAL.character_index == 0:
		current_character_name = "Elves"
		characterfeaturename.text = "Agility"
		charactertypename.text = "Elves"
		
		agilityfeature.visible = true
		strengthfeature.visible = false
		intelligencefeature.visible = false
		
		elves.top_level = true
		dwarfs.top_level = false
		humans.top_level = false
		
		elves.position.x = current_character_position_x
		elves.position.y = current_character_position_y
		elves.size.x = current_character_size_x
		elves.size.y = current_character_size_y
		elves.modulate = current_character_transparent
		
		dwarfs.position.x = left_character_position_x
		dwarfs.position.y = other_character_position_y
		dwarfs.size.x = other_character_size_x
		dwarfs.size.y = other_character_size_y
		dwarfs.modulate = other_character_transparent
		
		humans.position.x = right_character_position_x
		humans.position.y = other_character_position_y
		humans.size.x = other_character_size_x
		humans.size.y = other_character_size_y
		humans.modulate = other_character_transparent



	elif GLOBAL.character_index == 1:
		current_character_name = "Dwarfs"
		characterfeaturename.text = "Strength"
		charactertypename.text = "Dwarfs"
		
		agilityfeature.visible = false
		strengthfeature.visible = true
		intelligencefeature.visible = false
		
		elves.top_level = false
		dwarfs.top_level = true
		humans.top_level = false
		
		elves.position.x = right_character_position_x
		elves.position.y = other_character_position_y
		elves.size.x = other_character_size_x
		elves.size.y = other_character_size_y
		elves.modulate = other_character_transparent
		
		dwarfs.position.x = current_character_position_x
		dwarfs.position.y = current_character_position_y
		dwarfs.size.x = current_character_size_x
		dwarfs.size.y = current_character_size_y
		dwarfs.modulate = current_character_transparent
		
		humans.position.x = left_character_position_x
		humans.position.y = other_character_position_y
		humans.size.x = other_character_size_x
		humans.size.y = other_character_size_y
		humans.modulate = other_character_transparent



	elif GLOBAL.character_index == -1:
		current_character_name = "Humans"
		characterfeaturename.text = "Intelligence"
		charactertypename.text = "Humans"
		
		agilityfeature.visible = false
		strengthfeature.visible = false
		intelligencefeature.visible = true
		
		elves.top_level = false
		dwarfs.top_level = false
		humans.top_level = true
		
		elves.position.x = left_character_position_x
		elves.position.y = other_character_position_y
		elves.size.x = other_character_size_x
		elves.size.y = other_character_size_y
		elves.modulate = other_character_transparent
		
		dwarfs.position.x = right_character_position_x
		dwarfs.position.y = other_character_position_y
		dwarfs.size.x = other_character_size_x
		dwarfs.size.y = other_character_size_y
		dwarfs.modulate = other_character_transparent
		
		humans.position.x = current_character_position_x
		humans.position.y = current_character_position_y
		humans.size.x = current_character_size_x
		humans.size.y = current_character_size_y
		humans.modulate = current_character_transparent







func disable_create():
	charactercreatebutton.modulate = GLOBAL.disable_button_transparent
	charactercreatebutton.disabled = true
	
func enable_create():
	charactercreatebutton.modulate = GLOBAL.enable_button_transparent
	charactercreatebutton.disabled = false




func _on_character_create_button_pressed():
	GLOBAL.player_character_name = characternameinput.text
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/navigation-menu.tscn")




func _on_right_choice_button_pressed():
	go_right()



func _on_left_choice_button_pressed():
	go_left()




func go_right():
	GLOBAL.character_index += 1

func go_left():
	GLOBAL.character_index -= 1










