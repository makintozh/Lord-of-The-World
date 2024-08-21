extends Node



@onready var error_dialogue = $ErrorDialogue
@onready var transparent_back = $TransparentBack





func error_dialogue_starter(reason: String):
	if not error_dialogue.is_running():
		transparent_back.visible = true
		error_dialogue.variables["reason"] = reason + "       " + str(OS.get_version()) + "    " + str(OS.get_name())
		error_dialogue.start()


func _on_error_dialogue_dialogue_signal(value: String) -> void:
	match value:
		'RESTART': SceneManager.restart_application()
