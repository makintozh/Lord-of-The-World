extends Control



@onready var back_dialogue = $BackDialogue
@onready var transparent_back = $TransparentBack




#Вход в Таверну
func _on_tavern_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/tavern.tscn")

#Вход в Биомы
func _on_biom_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/biom.tscn")

#Вход в Кланы
func _on_clans_hall_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/clanshall.tscn")

#Вход в Лигу
func _on_league_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/league.tscn")



func _on_back_button_pressed():
	if not back_dialogue.is_running():
		transparent_back.visible = true
		back_dialogue.start()



func close_dialogue():
	back_dialogue.stop()
	transparent_back.visible = false




func _on_back_dialogue_dialogue_signal(value):
	
	print(value)
	
	if value == 'YES':
		GLOBAL.from_change_server = false
		SceneManager.go_to_scene("res://src/scenes/auth-scenes/choice_server.tscn")

	if value == 'NO':
		close_dialogue()







