extends Control











func _on_close_button_pressed():
	queue_free()






func _on_sign_out_button_pressed():
	GLOBAL.sign_out = true
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")





