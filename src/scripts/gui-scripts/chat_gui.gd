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
@onready var refresh = $Refresh




@export var opened_chat_position_y = -600
@export var opened_chat_size_y = 500
@export var closed_chat_position_y = -221
@export var mini_chat_active : bool = true
@export var websocket_url = "ws://" + GLOBAL.choiced_server_address + "/ws/chat/1"




var socket = WebSocketPeer.new()
var empty_input : bool = false
var bearer_header = ["Authorization: Bearer " + GLOBAL.from_auth_token]
var is_opened:bool = false
var is_max:bool = false
var json_response
var token = JSON.stringify({
		"token":GLOBAL.from_auth_token
	})




@onready var websocket_thread = Thread.new()
@onready var message_sender_thread = Thread.new()




func _ready() -> void:
	load_chat_history_from_api(15)
	websocket_thread.start(connect_to_socket)
	close_chat()




func _exit_tree():
	if websocket_thread.is_started():
		websocket_thread.wait_to_finish()
		
	if message_sender_thread.is_started():
		message_sender_thread.wait_to_finish()









func load_chat_history_from_api(quantity : int):
	api.request("http://" + GLOBAL.choiced_server_address + "/chat/1/messages?quantity=" + str(quantity), bearer_header, HTTPClient.METHOD_GET)
	open_chat_hitbox.visible = false
	messages_label.visible = false
	show_chat_button.disabled = true
	hide_chat_button.disabled = true




func _on_api_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	print(api_response)
	print('%d %s' % [response_code, '  Chat History Load'])


	for message in api_response:
		messages_label.append_text("[font=res://src/fonts/inika/Inika-Bold.ttf] %s [/font]:  %s \n" % [message.username , message.text])


	if response_code == 200:
		await  get_tree().create_timer(0.5).timeout
		show_chat_button.disabled = false
		hide_chat_button.disabled = false
		open_chat_hitbox.visible = true
		refresh.visible = false
		messages_label.visible = true
		print(json_response)
		message_sender_thread.start(display_messages)
		print('message_sender_thread   STARTED!')





func connect_to_socket():
	socket.set_handshake_headers(bearer_header)
	if socket.connect_to_url(websocket_url) != OK:
		printerr("[WEB-SOCKET] Невозможно подключиться!")
	


func _physics_process(_delta: float) -> void:
	socket.poll()


	var state = socket.get_ready_state()




	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var response = socket.get_packet().get_string_from_utf8()
			json_response = JSON.parse_string(response)
			print("\n[WEB-SOCKET] %s %s" % [response, "\n"])
			
			
			if json_response:
				if !json_response.text == "You are successfully connected to chat!":
					#message_sender_thread.call('display_messages')
					display_messages()



			if is_opened and !messages_label.position.y == -844:
				is_max = true
				messages_label.position.y -= 22
				messages_label.size.y += 20
			if messages_label.position.y == -850 and !messages_label.size.y == 625:
				messages_label.size.y += 15
				
				
				
	elif state == WebSocketPeer.STATE_CLOSED:
			var code = socket.get_close_code()
			printerr("\n[WEB-SOCKET] Оборвано соединение с Веб-Сокет: %d. Clean: %s" % [code, code != -1])

	if input.text == '':
		empty_input = true
		send_button.disabled = true
	else:
		empty_input = false
		send_button.disabled = false





func display_messages():
	if json_response:
		if !json_response.text == "You are successfully connected to chat!":
			messages_label.append_text("[font=res://src/fonts/inika/Inika-Bold.ttf] %s [/font]:  %s \n" % [json_response.username , json_response.text])




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



	if send_button.disabled == false:
		await socket.send_text(msg)
		print('[WEB-SOCKET] %s   SENDED' % [msg])
		input.text = ""
























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
		messages_label.position.y = opened_chat_position_y
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
	if scene.name == "Navigation-menu":
		$"../PlayerGui".navigation.visible = true
	else:
		$"../PlayerGui".navigation.visible = false
	chat_to_down()




func hide_chat():
	chat_panel.visible = false
	messages_label.visible = false
	hide_chat_button.visible = false
	open_chat_hitbox.visible = false
	show_chat_button.visible = true
	refresh.visible = false




func show_chat():
	chat_panel.visible = true
	messages_label.visible = true
	open_chat_hitbox.visible = true
	hide_chat_button.visible = true
	show_chat_button.visible = false
	$"../PlayerGui"._on_navigation_close_hit_box_pressed()





func _on_hide_chat_pressed() -> void:
	hide_chat()



func _on_show_chat_pressed() -> void:
	show_chat()
