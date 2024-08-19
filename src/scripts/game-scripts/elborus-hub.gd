extends Control





func _process(_delta):
	$Camera2D.position.y = $Scroll.value






func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/biom.tscn")
