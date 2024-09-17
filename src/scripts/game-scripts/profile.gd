extends Control






func _ready():
	$PlayerGui.navigation.visible = false
	$PlayerGui.actions.visible = false
	$ChatGui._on_hide_chat_pressed()
	
	
	$MarginContainer10/TextureRect/Label.text = GLOBAL.player_character_name






func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_back_button_pressed()



#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/tavern.tscn")


func _on_back_pressed() -> void:
	_on_back_button_pressed()
