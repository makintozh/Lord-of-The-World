extends Control







func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_back_button_pressed()






func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/biom.tscn")


func _on_battle_pressed():
	SceneManager.go_to_scene("res://src/scenes/battle-scenes/elborus-battle.tscn")


func _on_battle_1_pressed():
	SceneManager.go_to_scene("res://src/scenes/battle-scenes/elborus-battle.tscn")


func _on_battle_2_pressed():
	SceneManager.go_to_scene("res://src/scenes/battle-scenes/elborus-battle.tscn")


func _on_battle_3_pressed():
	SceneManager.go_to_scene("res://src/scenes/battle-scenes/elborus-battle.tscn")


func _on_battle_5_pressed():
	SceneManager.go_to_scene("res://src/scenes/battle-scenes/elborus-battle.tscn")


func _on_battle_6_pressed():
	SceneManager.go_to_scene("res://src/scenes/battle-scenes/elborus-battle.tscn")


func _on_battle_7_pressed():
	SceneManager.go_to_scene("res://src/scenes/battle-scenes/elborus-battle.tscn")


func _on_battle_8_pressed():
	SceneManager.go_to_scene("res://src/scenes/battle-scenes/elborus-battle.tscn")
