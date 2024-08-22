extends Control

var servers = []  # Здесь будет храниться список серверов

func _ready():
	# Предположим, что вы получаете JSON данные от сервера
	var json_data = '{"servers":[{"id":1,"name":"Server 1","address":"192.168.1.1"},{"id":2,"name":"Server 2","address":"192.168.1.2"}]}'
	parse_json(json_data)

func parse_json(json_string: String):
	var result = JSON.parse_string(json_string)
	servers = result["servers"]
	create_server_buttons()

func create_server_buttons():
	var container = $VBoxContainer  # Предполагается, что у вас есть VBoxContainer в сцене

	for server in servers:
		var button = Button.new()
		button.text = "Play " + server.name
		button.pressed.connect(self._on_play_button_pressed.bind(server["address"]))
		
		var label = Label.new()
		label.text = "ID: " + str(server.id) + "\nAddress: " + server.address
		
		container.add_child(label)
		container.add_child(button)

func _on_play_button_pressed(address: String):
	print("Выбранный сервер: " + address)
	# Здесь вы можете добавить логику для подключения к серверу
