extends Control



@onready var actions = $Actions

@onready var settings_gui = $Settings

@onready var nickname_label = $PlayerInformation/PlayerName/Names

@onready var current_home_texture = $Home/Home/Home/Main

@onready var navigation = $Navigation
@onready var navigation_closed = $Navigation/NavigationClosed
@onready var navigation_close_hitbox = $Navigation/NavigationCloseHitBox
@onready var navigation_opened = $Navigation/NavigationOpened
var navigation_active : bool = false




@onready var scene = get_tree().get_root().get_child(SceneManager.singleton_count)




func _ready() -> void:
	nickname_label.text = GLOBAL.player_character_name
	
	if scene.name == "Navigation-menu":
		current_home_texture.position.x = 190
	elif scene.name == "Tavern":
		current_home_texture.position.x = 0




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
	$"../ChatGui".chat_panel.visible = false
	$"../ChatGui".hide_chat_button.visible = false
	$"../ChatGui".scroll_container.visible = false





func _on_navigation_close_hit_box_pressed() -> void:
	navigation_active = false
	$"../ChatGui".chat_panel.visible = true
	$"../ChatGui".hide_chat_button.visible = true
	$"../ChatGui".scroll_container.visible = true





func _on_tavern_hit_box_pressed() -> void:
	if !scene.name == "Tavern":
		SceneManager.go_to_scene("res://src/scenes/game-scenes/tavern.tscn")



func _on_city_hit_box_pressed() -> void:
	if !scene.name == "Navigation-menu":
		SceneManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")
