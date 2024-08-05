extends Node2D



#Камера2D
@onready var camera_view = $Camera2D

@onready var top_button = $NaviagteBiom/TopButton/TopButtonContainer
@onready var bottom_button = $NaviagteBiom/BottomButton/BottomButtonContainer


var top_biom_position_y = 1450
var bottom_biom_position_y = 453







#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/navigation-menu.tscn")







func _on_civil_pressed():
	get_tree().change_scene_to_file("res://src/scenes/battle-scenes/civil-battle.tscn")





func _on_top_button_pressed():
	camera_view.position.y = 453
	top_button.visible = false
	bottom_button.visible = true




func _on_bottom_button_pressed():
	camera_view.position.y = 1450
	top_button.visible = true
	bottom_button.visible = false




func _on_elborus_pressed():
	get_tree().change_scene_to_file("res://src/scenes/battle-scenes/elborus-hub.tscn")


func _on_taurelious_pressed():
	get_tree().change_scene_to_file("res://src/scenes/battle-scenes/taurelious.tscn")


func _on_torres_mortes_pressed():
	get_tree().change_scene_to_file("res://src/scenes/battle-scenes/torres-mortes.tscn")


func _on_forest_pressed():
	get_tree().change_scene_to_file("res://src/scenes/battle-scenes/forest.tscn")


func _on_carvaras_pressed():
	get_tree().change_scene_to_file("res://src/scenes/battle-scenes/carvaras.tscn")


func _on_nordtoppen_pressed():
	get_tree().change_scene_to_file("res://src/scenes/battle-scenes/nordtoppen.tscn")


func _on_keyfand_pressed():
	get_tree().change_scene_to_file("res://src/scenes/battle-scenes/keyfand.tscn")


func _on_meches_pressed():
	get_tree().change_scene_to_file("res://src/scenes/battle-scenes/meches.tscn")
