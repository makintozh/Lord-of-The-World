extends Control





@onready var chat_panel = $"Chat-Panel"
@onready var open_chat_panel = $"Open-Chat-Panel"
@onready var messages_label = $"ScrollContainer/Messages"
@onready var scroll_container = $ScrollContainer
@onready var open_chat_hitbox = $"Open-Chat-Hitbox"
@onready var show_chat_button = $"Show-Chat"
@onready var hide_chat_button = $"Hide-Chat"
@onready var hide_chat_label = $"Hide-Chat/Hide"
@onready var input = $"Open-Chat-Panel/Input"
@onready var chat_gui = $"."
@onready var scene = get_tree().get_root().get_child(SceneManager.singleton_count)
@onready var api = $"ASYNC-API"




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
var socketthread = Thread.new()
var httpthread = Thread.new()



var token = JSON.stringify({
		"token":GLOBAL.from_auth_token
	})
	
	




func _ready() -> void:
	
	#connect_to_socket()
	socketthread.start(connect_to_socket)
	httpthread.start(touch_api.bind(4))









func touch_api(quantity : int):
	messages_label.text = loading_text
	message_list.clear()
	await api.request("http://" + GLOBAL.choiced_server_address + "/chat/1/messages?quantity=" + str(quantity), bearer_header, HTTPClient.METHOD_GET)




func connect_to_socket():
	socket.set_handshake_headers(bearer_header)
	if await socket.connect_to_url(websocket_url) != OK:
		printerr("[WEB-SOCKET] Невозможно подключиться!")
	



func _process(_delta):
	socket.poll()


	var state = socket.get_ready_state()


	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var response = socket.get_packet().get_string_from_utf8()
			var json_response = JSON.parse_string(response)
			print("\n[WEB-SOCKET] %s %s" % [response, "\n"])
			
			await chat_to_down()
			if json_response:
				#await get_tree().create_timer(2.0).timeout
				await _on_MessageReceived(json_response)




	elif state == WebSocketPeer.STATE_CLOSED:
			var code = socket.get_close_code()
			printerr("\n[WEB-SOCKET] Оборвано соединение с Веб-Сокет: %d. Clean: %s" % [code, code != -1])
			connect_to_socket()
			socket.close()
	
	if messages_label.text == loading_text:
		messages_label.add_theme_font_size_override("normal_font_size", 30)
	else:
		messages_label.add_theme_font_size_override("normal_font_size", 16)




func chat_to_down():
	var s = 0
	while s < 200:
		s += 1
		scroll_container.scroll_vertical += 9999








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
	await get_tree().create_timer(0.3).timeout
	
	if input.text == "":
		empty_input = true
	else:
		empty_input = false
	
	
	if !scroll_container.position.y == closed_chat_position_y and !scroll_container.position.y == -830:
		if !empty_input:
			await get_tree().create_timer(0.3).timeout
			scroll_container.position.y -= 25
			scroll_container.size.y += 25


	var s = 0
	while s < 400:
		s += 1
		input.text = ""
		
	chat_to_down()











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
	
	#print("Массив: %s  |||  Размер массива (size): %d" % [message_list , message_list.size()])



	text = text.strip_edges()
	messages_label.text = text
	#await get_tree().create_timer(0.3).timeout
	
	
	
	chat_to_down()





func _on_open_chat_pressed() -> void:
	open_chat()


func _on_close_chat_pressed() -> void:
	close_chat()
	chat_to_down()





func open_chat():
	await touch_api(15)
	#mini_chat_active = false
	chat_panel.visible = false
	open_chat_panel.visible = true
	show_chat_button.visible = false
	open_chat_hitbox.visible = false
	hide_chat_button.visible = false
	$"../PlayerGui".navigation.visible = false
	messages_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	scroll_container.position.x = -222
	scroll_container.position.y = opened_chat_position_y
	scroll_container.size.x = 456
	scroll_container.size.y = opened_chat_size_y
	scroll_container.scale = Vector2(1.0 , 1.0)
	scroll_container.scroll_vertical = 99999
	scroll_container.vertical_scroll_mode = 1
	messages_label.visible_characters = -1
	scroll_container.visible = true
	
	#if scroll_container.position.y == -590:
			#scroll_container.size.y = 420
			
	chat_to_down()



func close_chat():
	await touch_api(4)
	var label_size = messages_label.get_total_character_count()
	print("Размер сообщений: %d" % [label_size])
	scroll_container.visible = true
	mini_chat_active = true
	chat_panel.visible = true
	open_chat_panel.visible = false
	open_chat_hitbox.visible = true
	show_chat_button.visible = false
	hide_chat_button.visible = true
	scroll_container.position.x = -36
	scroll_container.position.y = closed_chat_position_y
	scroll_container.size.x = 99999
	scroll_container.size.y = 1003
	scroll_container.scale = Vector2(1.0 , 1.0)
	scroll_container.vertical_scroll_mode = 3
	scroll_container.scroll_vertical = 0
	chat_to_down()




func hide_chat():
	chat_panel.visible = false
	hide_chat_button.visible = false
	scroll_container.visible = false
	open_chat_hitbox.visible = false
	show_chat_button.visible = true




func show_chat():
	chat_panel.visible = true
	open_chat_hitbox.visible = true
	hide_chat_button.visible = true
	scroll_container.visible = true
	show_chat_button.visible = false






func _on_hide_chat_pressed() -> void:
	hide_chat()





func _on_show_chat_pressed() -> void:
	show_chat()
	$"../PlayerGui"._on_navigation_close_hit_box_pressed()
