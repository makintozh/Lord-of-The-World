extends Control


@onready var chat_panel = $"Chat-Panel"
@onready var open_chat_panel = $"Open-Chat-Panel"
@onready var messages_container = $"Messages-Container"


func _ready() -> void:
	close_chat()





func _on_open_chat_pressed() -> void:
	open_chat()


func _on_close_chat_pressed() -> void:
	close_chat()




func open_chat():
	chat_panel.visible = false
	open_chat_panel.visible = true
	messages_container.position.y = -856
	$"Messages-Container/Label3".autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	$"Messages-Container/Label3".text_overrun_behavior = TextServer.OVERRUN_NO_TRIM




func close_chat():
	chat_panel.visible = true
	open_chat_panel.visible = false
	messages_container.position.y = -212
	$"Messages-Container/Label3".autowrap_mode = TextServer.AUTOWRAP_OFF
	$"Messages-Container/Label3".text_overrun_behavior = TextServer.OVERRUN_ADD_ELLIPSIS
