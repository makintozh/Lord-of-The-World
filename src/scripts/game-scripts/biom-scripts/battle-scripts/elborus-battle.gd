extends Control





#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/hub-scenes/elborus-hub.tscn")
