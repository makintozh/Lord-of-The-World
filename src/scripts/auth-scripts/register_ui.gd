extends Node2D

@onready var emailinput = $UI/EmailDataUI/Email
@onready var usernameinput = $UI/LoginDataUI/Login
@onready var passwordinput = $UI/PasswordDataUI/Password
@onready var confirmpasswordinput = $UI/ConfirmPasswordDataUI/ConfirmPassword
@onready var registerbutton = $NavigationContainer/RegisterButton
@onready var failed = $FailedToConnect
@onready var waitingresponse = $WaitingResponse




@onready var api = $APIRequest
var authlink = "http://31.129.54.119:80/register"

var signupped = false
var privacynotice_enabled = false

var data_path = "user://data.cfg"


func _ready():
	registerbutton.disabled = false








func _process(_delta):
	checkinputdata()
	



func checkinputdata():
	if confirmpasswordinput.text != passwordinput.text:
		disable_register()
	elif emailinput.text.is_empty() or usernameinput.text.is_empty() or confirmpasswordinput.text.is_empty() or passwordinput.text.is_empty() or !privacynotice_enabled:
		disable_register()
	else:
		enable_register()






func disable_register():
	registerbutton.modulate = GLOBAL.disable_button_transparent
	registerbutton.disabled = true
	
func enable_register():
	registerbutton.modulate = GLOBAL.enable_button_transparent
	registerbutton.disabled = false





func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")




func _on_password_hide_button_toggled(toggled_on):
	if toggled_on:
		passwordinput.secret = false
		confirmpasswordinput.secret = false
	else:
		passwordinput.secret = true
		confirmpasswordinput.secret = true
		
		
		
		


func _on_sign_up_button_pressed():
	waitingresponse.visible = true
	var authpost = JSON.stringify({
		"email":emailinput.text,
		"username":usernameinput.text,
		"password":passwordinput.text
		})
		
		
	api.request(authlink, [], HTTPClient.METHOD_POST, authpost)
	print(authpost)
	await get_tree().create_timer(20).timeout
	GLOBAL.failed_reason = "No Internet"
	failed.visible = true





func _on_http_request_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	var post_response = JSON.stringify(body.get_string_from_utf8())
	print("Ответ: " + str(post_response))
	print(headers)
	print("Код: " + str(response_code))
	if response_code == 200:
		signupped = true
		GLOBAL.username = str(usernameinput.text)
		GLOBAL.password = str(passwordinput.text)
		get_tree().change_scene_to_file("res://src/scenes/auth-scenes/login_ui.tscn")
	else:
		GLOBAL.failed_reason = str(post_response.replace('"',""))
		waitingresponse.visible = false
		failed.visible = true







func _on_privacy_notice_check_box_toggled(toggled_on):
	if toggled_on:
		privacynotice_enabled = true
	else:
		privacynotice_enabled = false









