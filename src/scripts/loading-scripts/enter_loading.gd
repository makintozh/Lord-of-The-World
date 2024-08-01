extends Control

@onready var version = $Version/Version/Version
@onready var gamename = $Name/Name/Name



func _ready():
	version.text = ProjectSettings.get_setting("application/config/version")
	gamename.text = ProjectSettings.get_setting("application/config/name")



	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")
