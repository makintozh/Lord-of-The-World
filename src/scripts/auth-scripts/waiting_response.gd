extends Control

@onready var refresh = $Refresh/Refresh/Refresh
@onready var refresh_animation = $Refresh/Refresh/Refresh/RefreshAnimation

var api = HTTPClient.new()


func _process(_delta):
	refresh_animation.play("refreshing")


func _on_cancel_pressed():
	api.close()
	queue_free()



