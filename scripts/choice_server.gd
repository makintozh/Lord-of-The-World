extends Node2D




func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/login_ui.tscn")


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/character_create.tscn")
