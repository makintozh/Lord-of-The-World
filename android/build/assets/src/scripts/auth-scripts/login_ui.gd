extends Node2D


var data = ConfigFile.new()
var data_path = "user://data.cfg"
var data_name = "REMEMBER DATA"

var login_remember = "login"
var password_remember = "password"


@onready var login_data = $UI/LoginDataUI/Login
@onready var password_data = $UI/PasswordDataUI/Password
@onready var passwordhidebutton = $UI/PasswordHideUI/PasswordHideButton
@onready var loginbutton = $NavigationContainer/LoginButton
@onready var api = $APIRequest
@onready var failed = $FailedToConnect
@onready var waitingresponse = $WaitingResponse


var authlink = "http://31.129.54.119:80/auth"

var is_remember = false
var logged = false




func _ready():
	after_remember_me()
	if GLOBAL.username != "" and GLOBAL.password != "":
		login_data.text = GLOBAL.username
		password_data.text = GLOBAL.password





func remember_me():
	var login_remembered = login_data.text
	var pass_remembered = password_data.text
	data.set_value(data_name, "login", login_remembered)
	data.set_value(data_name, "password", pass_remembered)
	data.save_encrypted_pass(data_path, "makintosh")





func after_remember_me():
	if GLOBAL.username == "" and GLOBAL.password == "":
		data.load_encrypted_pass(data_path, "makintosh")
		login_data.text = data.get_value(data_name, login_remember, "")
		password_data.text = data.get_value(data_name, password_remember, "")




func _process(_delta):
	if is_remember and logged:
		remember_me()
		
	checkloginandpassword()




func _on_forgot_password_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/forgot_password.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")
	
	
func _on_sign_up_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/register_ui.tscn")






func _on_login_button_pressed():
	waitingresponse.visible = true
	var authpost = JSON.stringify({


		"username":login_data.text,
		"password":password_data.text


		})



	api.request(authlink, [], HTTPClient.METHOD_POST, authpost)
	print(authpost)
	await get_tree().create_timer(20).timeout
	GLOBAL.failed_reason = "No Internet"
	failed.visible = true


func _on_http_request_request_completed(result, response_code, headers, body):
	var post_response = JSON.stringify(body.get_string_from_utf8())
	print(str(result))
	print("Ответ: " + str(post_response))
	print(headers)
	print("Код: " + str(response_code))
	if response_code == 200:
		logged = true
		if logged and is_remember:
			remember_me()
		get_tree().change_scene_to_file("res://src/scenes/game-scenes/choice_server.tscn")
	else:
		GLOBAL.failed_reason = str(post_response.replace('"',""))
		waitingresponse.visible = false
		failed.visible = true
		logged = false




func checkloginandpassword():
	if login_data.text.is_empty() or password_data.text.is_empty():
		disable_login()
	else:
		enable_login()





func disable_login():
	loginbutton.modulate = GLOBAL.disable_button_transparent
	loginbutton.disabled = true
	
func enable_login():
	loginbutton.modulate = GLOBAL.enable_button_transparent
	loginbutton.disabled = false




func _on_remember_me_check_box_toggled(toggled_on):
	if toggled_on:
		is_remember = true



func _on_password_hide_button_toggled(toggled_on):
	if toggled_on:
		password_data.secret = false
	else:
		password_data.secret = true
	
	
	




