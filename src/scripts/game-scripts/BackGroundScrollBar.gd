extends VScrollBar

#Камера2D
@onready var camera_view = $"../../Camera2D"



func _process(_delta):
	camera_view.position.y = value #Вид Камеры = Значение Скроллинга
