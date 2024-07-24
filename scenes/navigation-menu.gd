extends Node2D

@onready var playernamelabel = $PlayerProfileUI/PlayerNameContainer/PlayerName
@onready var elvesicon = $PlayerProfileUI/PlayerProfileIcon/ElvesIcon
@onready var humansicon = $PlayerProfileUI/PlayerProfileIcon/HumansIcon
@onready var dwarftsicon = $PlayerProfileUI/PlayerProfileIcon/DwarftsIcon




func _ready():
	player_icon()
	playernamelabel.text = GLOBAL.player_character_name
	
	


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



func _on_tavern_pressed():
	get_tree().change_scene_to_file("res://scenes/tavern.tscn")


func _on_biom_pressed():
	get_tree().change_scene_to_file("res://scenes/biom.tscn")


func _on_clans_hall_pressed():
	get_tree().change_scene_to_file("res://scenes/clanshall.tscn")


func _on_league_pressed():
	get_tree().change_scene_to_file("res://scenes/league.tscn")










