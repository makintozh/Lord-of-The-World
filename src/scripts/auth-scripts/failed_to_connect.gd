extends Control


@onready var failed = $"."
@onready var failed_reason = $FailedToConnectLabel/FailedToConnectLabel/FailedToConnectLabel



func _process(_delta):
	check_reason()


func check_reason():
	failed_reason.text = GLOBAL.failed_reason
	
	if GLOBAL.failed_reason == "":
		failed_reason.text = "Failed To Connect"



func _on_back_pressed():
	failed.visible = false
