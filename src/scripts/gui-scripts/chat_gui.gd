extends Control





@onready var chat_panel = $"Chat-Panel"
@onready var open_chat_panel = $"Open-Chat-Panel"
@onready var messages_label = $"ScrollContainer/Messages"
@onready var scroll_container = $ScrollContainer
@onready var open_chat_button = $"Open-Chat"
@onready var input = $"Open-Chat-Panel/Input"



@onready var api = $APIRequest
var message_list = []

var socket = WebSocketPeer.new()
var websocket_url = "ws://" + GLOBAL.choiced_server_address + "/ws/chat/1"



var token = JSON.stringify({
	
		"token":GLOBAL.from_auth_token
		
	})



var bearer_header = ["Authorization: Bearer " + GLOBAL.from_auth_token]




func _ready() -> void:
	touch_api()
	connect_to_socket()
	close_chat()




func touch_api():
	await get_tree().create_timer(0.2).timeout
	message_list.clear()
	api.request("http://" + GLOBAL.choiced_server_address + "/chat/1/messages", bearer_header, HTTPClient.METHOD_GET)
	chat_to_down()



func connect_to_socket():
	socket.set_handshake_headers(bearer_header)
	if socket.connect_to_url(websocket_url) != OK:
		printerr("[WEB-SOCKET] Невозможно подключиться!")
	



func _process(_delta):
	socket.poll()


	var state = socket.get_ready_state()


	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var response = socket.get_packet().get_string_from_utf8()
			var json_response = JSON.parse_string(response)
			print("\n[WEB-SOCKET] %s %s" % [response, "\n"])
			
			
			if json_response:
				#await get_tree().create_timer(2.0).timeout
				_on_MessageReceived(json_response)
				chat_to_down()
			


	elif state == WebSocketPeer.STATE_CLOSED:
			var code = socket.get_close_code()
			printerr("\n[WEB-SOCKET] Оборвано соединение с Веб-Сокет: %d. Clean: %s" % [code, code != -1])
			connect_to_socket()
			socket.close()





func chat_to_down():
	scroll_container.scroll_vertical = 999999999999




func _on_send_pressed() -> void:
	
	var msg = JSON.stringify({
	
	"text": input.text
	
})
	print(msg)
	socket.send_text(msg)
	input.text = ""




func _on_api_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	print(api_response)
	
	#var username = api_response[0]["username"]
	#var text = api_response[0]["text"]
	#var message = username + ": " + text
	#message_list.append(message)
	
	#printerr(text)

	#for amount in message_list:
		#messages_label.text = message_list[0]

	
	for message in api_response:
		_on_MessageReceived(message)



func _on_MessageReceived(message):
	message_list.append(message)
	update_label()





func update_label():
	var text = ""
	
	
	for message in message_list:
		if "username" in message:
			text += message.username + ": " + message.text + "\n"


	text = text.strip_edges()
	messages_label.text = text
	chat_to_down()
	





func _on_open_chat_pressed() -> void:
	open_chat()


func _on_close_chat_pressed() -> void:
	close_chat()






func open_chat():
	chat_panel.visible = false
	open_chat_panel.visible = true
	open_chat_button.visible = false
	#messages_label.visible_characters = -1
	#messages_label.position.y = -856
	messages_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	scroll_container.position.y = -855
	scroll_container.size.y = 650
	scroll_container.scroll_vertical = 0
	scroll_container.vertical_scroll_mode = 1
	#messages_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	messages_label.text_overrun_behavior = TextServer.OVERRUN_NO_TRIM




func close_chat():
	chat_panel.visible = true
	open_chat_panel.visible = false
	open_chat_button.visible = true
	#messages_label.visible_characters = 50
	#messages_label.position.y = -212
	scroll_container.position.y = -214
	scroll_container.size.y = 74
	scroll_container.vertical_scroll_mode = 3
	scroll_container.scroll_vertical = 0
	messages_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	#messages_label.text_overrun_behavior = TextServer.OVERRUN_NO_TRIM
	messages_label.text_overrun_behavior = TextServer.OVERRUN_ADD_ELLIPSIS
