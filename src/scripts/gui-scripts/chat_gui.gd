extends Control





@onready var chat_panel = $"Chat-Panel"
@onready var open_chat_panel = $"Open-Chat-Panel"
@onready var messages_label = $"Messages"
@onready var open_chat_hitbox = $"Open-Chat-Hitbox"
@onready var show_chat_button = $"Show-Chat"
@onready var send_button = $"Open-Chat-Panel/Send"
@onready var hide_chat_button = $"Hide-Chat"
@onready var hide_chat_label = $"Hide-Chat/Hide"
@onready var input = $"Open-Chat-Panel/Input"
@onready var chat_gui = $"."
@onready var scene = get_tree().get_root().get_child(SceneManager.singleton_count)
@onready var api = $"APIRequest"




@export var opened_chat_position_y = -600
@export var opened_chat_size_y = 500
@export var closed_chat_position_y = -221
@export var mini_chat_active : bool = true
@export var loading_text:String = "Загрузка..."
@export var websocket_url = "ws://" + GLOBAL.choiced_server_address + "/ws/chat/1"




var message_list = []
var socket = WebSocketPeer.new()
var empty_input : bool = false
var bearer_header = ["Authorization: Bearer " + GLOBAL.from_auth_token]
var is_opened:bool = false
var is_max:bool = false



var token = JSON.stringify({
		"token":GLOBAL.from_auth_token
	})





@onready var api_thread = Thread.new()
@onready var websocket_thread = Thread.new()
@onready var mutex = Mutex.new()


func _ready() -> void:
	mutex.unlock()
	api_thread.start(touch_api.bind(15), 2)
	websocket_thread.start(connect_to_socket, 2)
	close_chat()



func _exit_tree():
	api_thread.wait_to_finish()
	websocket_thread.wait_to_finish()






func touch_api(quantity : int):
	messages_label.text = loading_text
	message_list.clear()
	await api.request("http://" + GLOBAL.choiced_server_address + "/chat/1/messages?quantity=" + str(quantity), bearer_header, HTTPClient.METHOD_GET)
	




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
				_on_MessageReceived(json_response)
				
			if is_opened and !messages_label.position.y == -850 and !empty_input:
				is_max = true
				messages_label.position.y -= 25
				messages_label.size.y += 15
			if messages_label.position.y == -850 and !messages_label.size.y == 625:
				messages_label.size.y += 15







	elif state == WebSocketPeer.STATE_CLOSED:
			var code = socket.get_close_code()
			printerr("\n[WEB-SOCKET] Оборвано соединение с Веб-Сокет: %d. Clean: %s" % [code, code != -1])
			connect_to_socket()
			socket.close()
	
	
	if messages_label.text == loading_text:
		messages_label.add_theme_font_size_override("normal_font_size", 30)
	else:
		messages_label.add_theme_font_size_override("normal_font_size", 16)




	if input.text == '':
		empty_input = true
	else:
		empty_input = false







func chat_to_down():
	messages_label.scroll_to_line(messages_label.get_line_count())








func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			_on_send_pressed()







func _on_send_pressed() -> void:
	var msg = JSON.stringify({
	
	"text": input.text
	
})


	print(msg)
	if send_button.disabled == false:
		await Thread.new().start(socket.send_text.bind(msg))
	
	send_button.disabled = true
	
	await get_tree().create_timer(0.5).timeout
	input.text = ""
	send_button.disabled = false













func _on_api_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	print(api_response)

	
	
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
	
	






func _on_open_chat_pressed() -> void:
	open_chat()


func _on_close_chat_pressed() -> void:
	close_chat()






func open_chat():
	is_opened = true
	messages_label.size.x = 465
	messages_label.position.x = -227
	if !is_max:
		messages_label.size.y = 355
		messages_label.position.y = -575
	else:
		messages_label.size.y = 625
		messages_label.position.y = -850
	chat_panel.visible = false
	open_chat_panel.visible = true
	show_chat_button.visible = false
	open_chat_hitbox.visible = false
	hide_chat_button.visible = false
	$"../PlayerGui".navigation.visible = false
	messages_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	messages_label.visible_characters = -1
	chat_to_down()





func close_chat():
	is_opened = false
	mini_chat_active = true
	chat_panel.visible = true
	open_chat_panel.visible = false
	open_chat_hitbox.visible = true
	show_chat_button.visible = false
	hide_chat_button.visible = true
	messages_label.position.x = -35
	messages_label.position.y = closed_chat_position_y
	messages_label.size.x = 99999
	messages_label.size.y = 88
	chat_to_down()




func hide_chat():
	chat_panel.visible = false
	messages_label.visible = false
	hide_chat_button.visible = false
	open_chat_hitbox.visible = false
	show_chat_button.visible = true




func show_chat():
	chat_panel.visible = true
	messages_label.visible = true
	open_chat_hitbox.visible = true
	hide_chat_button.visible = true
	show_chat_button.visible = false






func _on_hide_chat_pressed() -> void:
	hide_chat()





func _on_show_chat_pressed() -> void:
	show_chat()
	$"../PlayerGui"._on_navigation_close_hit_box_pressed()
