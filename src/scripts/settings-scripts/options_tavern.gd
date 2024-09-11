extends Control




@onready var servername = $OptionContainer/ServerName



func _ready():
	servername.text += GLOBAL.choiced_server_name





func _on_close_button_pressed():
	self.visible = false






func _on_sign_out_button_pressed():
	GLOBAL.sign_out = true
	SceneManager.go_to_scene("res://src/scenes/auth-scenes/login_ui.tscn")





func _on_change_server_pressed():
	GLOBAL.from_change_server = true
	SceneManager.go_to_scene("res://src/scenes/auth-scenes/choice_server.tscn")
	
	
	
	
	
	
