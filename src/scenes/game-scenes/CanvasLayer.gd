extends CanvasLayer



func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
