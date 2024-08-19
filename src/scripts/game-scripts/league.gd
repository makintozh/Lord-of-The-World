extends Control





#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")
