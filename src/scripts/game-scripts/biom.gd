extends Node2D



#Камера2D
@onready var camera_view = $Camera2D
@onready var scrollbar = $BackGroundScrollBar




#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/navigation-menu.tscn")





func _on_back_ground_scroll_bar_value_changed(value):
			camera_view.position.y = value   #Вид Камеры = Значение Скроллинга









