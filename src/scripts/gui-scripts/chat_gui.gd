extends Control





@onready var chat_panel = $"Chat-Panel"
@onready var open_chat_panel = $"Open-Chat-Panel"
@onready var messages_label = $"ScrollContainer/Messages"
@onready var scroll_container = $ScrollContainer
@onready var open_chat_button = $"Open-Chat"
@onready var hide_chat_button = $"Hide-Chat"
@onready var hide_chat_label = $"Hide-Chat/Hide"
@onready var input = $"Open-Chat-Panel/Input"


var empty_input : bool = false


var mini_chat_active : bool = true


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
	api.request("http://" + GLOBAL.choiced_server_address + "/chat/1/messages?quantity=45", bearer_header, HTTPClient.METHOD_GET)




func connect_to_socket():
	socket.set_handshake_headers(bearer_header)
	if socket.connect_to_url(websocket_url) != OK:
		printerr("[WEB-SOCKET] Невозможно подключиться!")
	



func _process(_delta):
	mini_chat_manager()
	
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




	elif state == WebSocketPeer.STATE_CLOSED:
			var code = socket.get_close_code()
			printerr("\n[WEB-SOCKET] Оборвано соединение с Веб-Сокет: %d. Clean: %s" % [code, code != -1])
			connect_to_socket()
			socket.close()





func chat_to_down():
	for i in range(5):
		scroll_container.scroll_vertical = 9999








func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			_on_send_pressed()







func _on_send_pressed() -> void:
	
	var msg = JSON.stringify({
	
	"text": input.text
	
})
	print(msg)
	socket.send_text(msg)
	if input.text == "":
		empty_input = true
		
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
			text += "[font=res://src/fonts/inika/Inika-Bold.ttf]" + message.username + "[/font]: " + message.text + "\n"


	text = text.strip_edges()
	messages_label.text = text
	if !scroll_container.position.y == -215 and !scroll_container.position.y == -850:
		if !empty_input:
			scroll_container.position.y -= 25
			scroll_container.size.y += 20
	chat_to_down()





func _on_open_chat_pressed() -> void:
	open_chat()


func _on_close_chat_pressed() -> void:
	close_chat()
	chat_to_down()





func open_chat():
	mini_chat_active = false
	chat_panel.visible = false
	open_chat_panel.visible = true
	open_chat_button.visible = false
	hide_chat_button.visible = false
	#messages_label.visible_characters = -1
	#messages_label.position.y = -856
	messages_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	scroll_container.position.x = -222
	scroll_container.position.y = -850
	scroll_container.size.x = 456
	scroll_container.size.y = 620
	scroll_container.scale = Vector2(1.0 , 1.0)
	scroll_container.scroll_vertical = 99999
	scroll_container.vertical_scroll_mode = 1
	#messages_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	#messages_label.text_overrun_behavior = TextServer.OVERRUN_NO_TRIM
	scroll_container.visible = true
	if scroll_container.position.y == -590:
			scroll_container.size.y = 420
	chat_to_down()



func close_chat():
	scroll_container.visible = true
	mini_chat_active = true
	chat_panel.visible = true
	open_chat_panel.visible = false
	open_chat_button.visible = true
	hide_chat_button.visible = true
	#messages_label.visible_characters = 50
	#messages_label.position.y = -212
	scroll_container.position.x = -36
	scroll_container.position.y = -220
	scroll_container.size.y = 83
	scroll_container.scale = Vector2(1.0 , 1.0)
	scroll_container.vertical_scroll_mode = 3
	scroll_container.scroll_vertical = 0
	#messages_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	##messages_label.text_overrun_behavior = TextServer.OVERRUN_NO_TRIM
	#messages_label.text_overrun_behavior = TextServer.OVERRUN_ADD_ELLIPSIS
	chat_to_down()


func hide_chat():
	chat_panel.visible = false
	open_chat_button.visible = false
	hide_chat_button.position.x = 210
	hide_chat_label.text = "показать"


func show_chat():
	chat_panel.visible = true
	open_chat_button.visible = true
	hide_chat_button.position.x = -86
	hide_chat_label.text = "скрыть"


func mini_chat_manager():
	if mini_chat_active:
		show_chat()
		chat_to_down()
	else:
		hide_chat()



func _on_hide_chat_pressed() -> void:
	if mini_chat_active:
		mini_chat_active = false
		scroll_container.visible = false
	else:
		mini_chat_active = true
		scroll_container.visible = true
		chat_to_down()
	
	
