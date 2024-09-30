extends Control




@onready var navigation_menu = $"."








func _process(_delta: float) -> void:
	adaptive_keyboard()





func adaptive_keyboard():
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		var height = DisplayServer.virtual_keyboard_get_height()
		navigation_menu.position.y = -height/2.5







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


func _on_sieges_pressed() -> void:
	pass # Replace with function body.


func _on_back_button_pressed():
	#if not back_dialogue.is_running():
		#transparent_back.visible = true
		#back_dialogue.start()
	pass
