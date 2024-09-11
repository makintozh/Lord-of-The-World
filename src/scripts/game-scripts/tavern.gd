extends Control


@onready var username = $ScrollContainer/TavernProfileUI/UsernameContainer/Username




func _ready():
	username.text = GLOBAL.player_character_name




func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_back_button_pressed()



#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")
