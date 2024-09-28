extends Control



@onready var actions = $Actions

@onready var settings_gui = $Settings

@onready var nickname_label = $PlayerInformation/PlayerName/Names

@onready var current_home_texture = $Home/Main

@onready var navigation = $Navigation
@onready var navigation_closed = $Navigation/NavigationClosed
@onready var navigation_close_hitbox = $Navigation/NavigationCloseHitBox
@onready var navigation_opened = $Navigation/NavigationOpened
@onready var maximized_resources = $PlayerInformation/MAXIMIZEDPlayerResources
@onready var minimized_resources = $PlayerInformation/MINIMIZEDPlayerResources
@onready var menu_tavern = $Home/Tavern
@onready var menu_tasks = $Home/Tasks
@onready var menu_city = $Home/City
@onready var menu_shop = $Home/Shop
@onready var menu_mail = $Home/Mail
var navigation_active : bool = false




@onready var scene = get_tree().get_root().get_child(SceneManager.singleton_count)


var current_menu_scale = Vector2(1.2, 1.2)
var other_menu_scale = Vector2(1.0, 1.0)


func _ready() -> void:
	minimize_resources()
	
	nickname_label.text = GLOBAL.player_character_name


	if scene.name == "Navigation-menu":
		current_home_texture.position.x = 191
		menu_city.scale = current_menu_scale
		menu_city.position = Vector2(212.0, 1152.0)
		navigation.visible = true
	else:
		menu_city.scale = other_menu_scale


	if scene.name == "Tavern" or scene.name == "Tavern-Inventory" or scene.name == "Tavern-Profile" or scene.name == "Tavern-Heroes":
		current_home_texture.position.x = -9
		menu_tavern.scale = current_menu_scale
		menu_tavern.position = Vector2(0.53, 1140.0)
		navigation.visible = false
	else:
		menu_tavern.scale = other_menu_scale




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



func maximize_resources():
	maximized_resources.visible = true
	minimized_resources = false

func minimize_resources():
	maximized_resources.visible = false
	minimized_resources = true



func _on_settings_button_pressed() -> void:
	settings_gui.visible = true


func _on_navigation_closed_pressed() -> void:
	navigation_active = true
	$"../ChatGui".chat_panel.visible = false
	$"../ChatGui".hide_chat_button.visible = false
	$"../ChatGui".messages_label.visible = false





func _on_navigation_close_hit_box_pressed() -> void:
	navigation_active = false
	$"../ChatGui".chat_panel.visible = true
	$"../ChatGui".hide_chat_button.visible = true
	$"../ChatGui".messages_label.visible = true





func _on_tavern_hit_box_pressed() -> void:
	if !scene.name == "Tavern":
		SceneManager.go_to_scene("res://src/scenes/game-scenes/tavern.tscn")



func _on_city_hit_box_pressed() -> void:
	if !scene.name == "Navigation-menu":
		SceneManager.go_to_scene("res://src/scenes/game-scenes/navigation-menu.tscn")


func _on_show_all_pressed() -> void:
	maximize_resources()


func _on_hide_all_pressed() -> void:
	minimize_resources()
