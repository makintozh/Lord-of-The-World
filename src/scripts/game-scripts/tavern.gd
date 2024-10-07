extends Control





func _ready():
	$PlayerGui.navigation.visible = false
	$PlayerGui.actions.visible = false
	$ChatGui._on_hide_chat_pressed()




func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_back_button_pressed()



#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")





func _on_profile_pressed() -> void:
	SceneManager.go_to_scene("res://src/scenes/game-scenes/profile.tscn")





func _on_inventory_pressed() -> void:
	SceneManager.go_to_scene("res://src/scenes/game-scenes/inventory.tscn")




func _on_heroes_pressed() -> void:
	SceneManager.go_to_scene("res://src/scenes/game-scenes/heroes.tscn")
