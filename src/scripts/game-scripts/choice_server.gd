extends Node2D




func _on_back_button_pressed():
	GLOBAL.sign_out = true
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/character_create.tscn")
