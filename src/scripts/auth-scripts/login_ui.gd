extends Control


var data = ConfigFile.new()
var data_path = "user://data.cfg"
var data_name = "REMEMBER DATA"

var login_remember = "login"
var password_remember = "password"


@onready var login_ui = $"."
@onready var login_data = $UI/LoginDataUI/Login
@onready var password_data = $UI/PasswordDataUI/Password
@onready var passwordhidebutton = $UI/PasswordHideUI/PasswordHideButton
@onready var loginbutton = $Navigation/NavigationContainer/LoginButton
@onready var api = $APIRequest
@onready var api_waitresponse_timer = $APIWaitResponseTimer
@onready var failed = $FailedToConnect
@onready var waitingresponse = $WaitingResponse



var is_remember = false
var logged = false





func _ready():
	after_remember_me()
	if GLOBAL.username != "" and GLOBAL.password != "":
		login_data.text = GLOBAL.username
		password_data.text = GLOBAL.password
		
		
		





func remember_me():
	if GLOBAL.is_remember:
		var login_remembered = login_data.text
		var pass_remembered = password_data.text
		data.set_value(data_name, "login", login_remembered)
		data.set_value(data_name, "password", pass_remembered)
		data.save_encrypted_pass(data_path, "makintosh")
		print("Saved: " + login_remembered + "  |||  " + pass_remembered)





func after_remember_me():
	if GLOBAL.username == "" and GLOBAL.password == "":
		data.load_encrypted_pass(data_path, "makintosh")
		login_data.text = data.get_value(data_name, login_remember, "")
		password_data.text = data.get_value(data_name, password_remember, "")
		if !FileAccess.file_exists(data_path):
			GLOBAL.sign_out = true
		if not GLOBAL.sign_out:
			_on_login_button_pressed()




func adaptive_keyboard():
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		var height = DisplayServer.virtual_keyboard_get_height()
		login_ui.position.y = -height/CONFIG.adaptive_keyboard_pixel






func _process(_delta):
	checkloginandpassword()
	adaptive_keyboard()




func _on_login_button_pressed():
	waitingresponse.visible = true
	
	var authpost = JSON.stringify({
		
		
		"username":login_data.text,
		"password":password_data.text
		
		
		})
		
	api.request(CONFIG.api_link + "/auth", CONFIG.api_headers, HTTPClient.METHOD_POST, authpost)
	print(authpost)
	#await get_tree().create_timer(20).timeout
	api_waitresponse_timer.start()




func _on_api_wait_response_timer_timeout() -> void:
	GLOBAL.failed_reason = "No Internet"
	failed.visible = true




func _on_http_request_request_completed(result, response_code, headers, body):
	var api_response = JSON.parse_string(body.get_string_from_utf8())
	var message = str(api_response["message"])
	var token = str(api_response["token"])
	
	
	print(str(result))
	print("Ответ: " + str(api_response))
	print("Сообщение: " + message)
	
	
	if token == "<null>":
		printerr("Токен: " + token)
	else:
		print("Токен: " + token)


	print(headers)
	print("Код: " + str(response_code))
	
	
	if !token == "<null>":
		GLOBAL.from_auth_token = token
		logged = true
		if logged and GLOBAL.is_remember:
			remember_me()
		SceneManager.go_to_scene("res://src/scenes/auth-scenes/choice_server.tscn")
	else:
		GLOBAL.failed_reason = message.replace('"',"")
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
		GLOBAL.is_remember = true
	else:
		GLOBAL.is_remember = false



func _on_password_hide_button_toggled(toggled_on):
	if toggled_on:
		password_data.secret = false
	else:
		password_data.secret = true
	
	
	














func _on_forgot_password_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/auth-scenes/forgot_password.tscn")


	
func _on_sign_up_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/auth-scenes/register_ui.tscn")
