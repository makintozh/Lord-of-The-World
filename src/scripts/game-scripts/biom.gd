extends Control






#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")







func _on_civil_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/civil.tscn")


func _on_taurelious_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/taurelious.tscn")


func _on_elborus_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/elborus.tscn")


func _on_torres_mortes_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/torresmortes.tscn")


func _on_forest_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/forest.tscn")


func _on_carvaras_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/carvaras.tscn")


func _on_nordtoppen_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/nordtoppen.tscn")


func _on_keyfand_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/keyfand.tscn")


func _on_meches_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/meches.tscn")


func _on_celestial_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/battle-scenes/celestial.tscn")





