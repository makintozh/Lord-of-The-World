extends Node2D


@onready var username = $TavernProfileUI/UsernameContainer/Username
@onready var elvesicon = $TavernProfileUI/PlayerProfileIcon/ElvesIcon
@onready var humansicon = $TavernProfileUI/PlayerProfileIcon/HumansIcon
@onready var dwarftsicon = $TavernProfileUI/PlayerProfileIcon/DwarftsIcon



func _ready():
	player_icon()
	username.text = GLOBAL.player_character_name




func player_icon():
	if GLOBAL.character_index == 0:
		elvesicon.visible = true
		humansicon.visible = false
		dwarftsicon.visible = false
	elif GLOBAL.character_index == 1:
		elvesicon.visible = false
		humansicon.visible = false
		dwarftsicon.visible = true
	elif GLOBAL.character_index == -1:
		elvesicon.visible = false
		humansicon.visible = true
		dwarftsicon.visible = false




func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game-scenes/navigation-menu.tscn")




func _on_options_button_pressed():
	pass 
