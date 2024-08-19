extends Control


@onready var username = $TavernProfileUI/UsernameContainer/Username


var options = preload("res://src/scenes/settings-scenes/options_tavern.tscn")


func _ready():
	username.text = GLOBAL.player_character_name











#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/navigation-menu.tscn")



#Если нажата кнопка "Настройки"
func _on_options_button_pressed():
	options.instantiate()
	add_child(options.instantiate())









