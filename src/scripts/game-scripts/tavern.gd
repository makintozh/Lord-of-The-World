extends Control


@onready var username = $ScrollContainer/TavernProfileUI/UsernameContainer/Username


var options = preload("res://src/scenes/settings-scenes/options_tavern.tscn")


func _ready():
	username.text = GLOBAL.player_character_name






#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")



#Если нажата кнопка "Настройки"
func _on_options_button_pressed():
	options.instantiate()
	add_child(options.instantiate())









