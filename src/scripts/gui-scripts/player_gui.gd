extends Control



@onready var settings_gui = $Settings

@onready var nickname_label = $PlayerInfo/VBox/NickName

@onready var navigation_closed = $Navigation/NavigationClosed
@onready var navigation_close_hitbox = $Navigation/NavigationCloseHitBox
@onready var navigation_opened = $Navigation/NavigationOpened
var navigation_active : bool = false



func _ready() -> void:
	nickname_label.text = GLOBAL.player_character_name




func _process(_delta):
	navigation_manager()




func navigation_manager():
	if navigation_active:
		navigation_closed.visible = false
		navigation_opened.visible = true
		navigation_close_hitbox.visible = true
		#$"../ChatGui".mini_chat_active = false
		#$"../ChatGui".scroll_container.visible = false
	else:
		navigation_closed.visible = true
		navigation_opened.visible = false
		navigation_close_hitbox.visible = false
		#$"../ChatGui".mini_chat_active = true
		#$"../ChatGui".scroll_container.visible = true



func _on_settings_button_pressed() -> void:
	settings_gui.visible = true


func _on_navigation_closed_pressed() -> void:
	navigation_active = true
	$"../ChatGui".mini_chat_active = false
	$"../ChatGui".scroll_container.visible = false





func _on_navigation_close_hit_box_pressed() -> void:
	navigation_active = false
	$"../ChatGui".mini_chat_active = true
	$"../ChatGui".scroll_container.visible = true





func _on_tavern_hit_box_pressed() -> void:
	SceneManager.go_to_scene("res://src/scenes/game-scenes/tavern.tscn")
