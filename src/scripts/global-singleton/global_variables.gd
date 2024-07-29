extends Node



var username = ""   #Ник Пользователя
var password = ""   #Пароль Пользователя

var failed_reason:String

var has_internet:bool

var player_character_name = ""    #Имя Персонажа Пользователя


var character_index = 0    #Индекс Выбранного Персонажа Пользователя


var enable_button_transparent = "ffffffff"    #Прозрачность Включённой Кнопки
var disable_button_transparent = "ffffff78"   #Прозрачность Отлючённой Кнопки

























@onready var internet = HTTPRequest.new()
@onready var request_timer = Timer.new()
var not_connection = preload("res://src/scenes/auth-scenes/not_internet_connection.tscn").instantiate()





func _ready():
	add_child(internet)
	_check_connection()
	request_timer.autostart = true
	request_timer.one_shot = false
	request_timer.wait_time = 5
	request_timer.timeout.connect(_check_connection)
	add_child(request_timer)
	internet.request_completed.connect(_on_request_completed)



func _check_connection():
	var error = internet.request("http://31.129.54.119:80/auth")
	if error != OK:
		printerr("No Internet Connection")
		has_internet = false
		get_tree().get_root().add_child(not_connection)




func _on_request_completed(result, response_code, headers, body):
	print("Yes Internet Connection")
	has_internet = true
	get_tree().get_root().remove_child(not_connection)













