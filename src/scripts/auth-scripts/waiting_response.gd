extends Control

@onready var refresh = $Refresh/Refresh/Refresh
@onready var refresh_animation = $Refresh/Refresh/Refresh/RefreshAnimation

var api = HTTPClient.new()


func _process(_delta):
	refresh_animation.play("refreshing")
	
	if GLOBAL.has_internet == false:
		self.visible = false


func _on_cancel_pressed():
	api.close()
	queue_free()











