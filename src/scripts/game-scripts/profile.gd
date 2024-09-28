extends Control




@onready var player_name = $PlayerCardDesign/PlayerName/PlayerName/PlayerNameLabel




func _ready():
	$PlayerGui.navigation.visible = false
	$PlayerGui.actions.visible = false
	$ChatGui._on_hide_chat_pressed()
	
	
	player_name.text = GLOBAL.player_character_name






func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_back_button_pressed()



#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/tavern.tscn")




func _on_back_hit_box_pressed() -> void:
	_on_back_button_pressed()
