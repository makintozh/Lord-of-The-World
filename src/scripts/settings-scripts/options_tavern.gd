extends Control




@onready var servername = $OptionContainer/ServerName



func _ready():
	servername.text += GLOBAL.choiced_server_name





func _on_close_button_pressed():
	queue_free()






func _on_sign_out_button_pressed():
	GLOBAL.sign_out = true
	SceneChangeManager.go_to_scene("res://src/scenes/auth-scenes/login_ui.tscn")





func _on_change_server_pressed():
	GLOBAL.from_change_server = true
	SceneChangeManager.go_to_scene("res://src/scenes/auth-scenes/choice_server.tscn")
	
	
	
	
	
	
