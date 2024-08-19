extends Control





func _process(_delta):
	$Camera2D.position.y = $Scroll.value






func _on_back_button_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/game-scenes/biom.tscn")
