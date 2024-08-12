extends Control




@onready var elvesicon = $PlayerProfileUI/PlayerProfileIcon/ElvesIcon
@onready var humansicon = $PlayerProfileUI/PlayerProfileIcon/HumansIcon
@onready var dwarftsicon = $PlayerProfileUI               /PlayerProfileIcon/DwarftsIcon




func _ready():
	player_icon()    #Аватарка Пользователя






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


#Вход в Таверну
func _on_tavern_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/tavern.tscn")

#Вход в Биомы
func _on_biom_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/biom.tscn")

#Вход в Кланы
func _on_clans_hall_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/clanshall.tscn")

#Вход в Лигу
func _on_league_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/league.tscn")










