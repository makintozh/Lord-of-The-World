extends Control




@onready var player_name = $PlayerCardDesign/PlayerName/PlayerName/PlayerNameLabel




func _ready():
	_on_close_button_pressed()
	_on_class_close_button_pressed()
	_on_rasa_close_button_pressed()
	$PlayerGui.navigation.visible = false
	$PlayerGui.actions.visible = false
	$ChatGui._on_hide_chat_pressed()
	
	
	player_name.text = GLOBAL.player_character_name






func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_back_button_pressed()



#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/tavern.tscn")




func _on_back_hit_box_pressed() -> void:
	_on_back_button_pressed()


func _on_parameter_button_pressed() -> void:
	$CardParameter/StrengthIcon.visible = false
	$CardParameter/CloseButton.visible = true
	$CardParameter/ParameterButton.visible = false
	$CardParameter/MaximizedParameter.visible = true


func _on_close_button_pressed() -> void:
	$CardParameter/StrengthIcon.visible = true
	$CardParameter/CloseButton.visible = false
	$CardParameter/ParameterButton.visible = true
	$CardParameter/MaximizedParameter.visible = false


func _on_class_hitbox_pressed() -> void:
	$ClassAllianceDescription.visible = true


func _on_class_close_button_pressed() -> void:
	$ClassAllianceDescription.visible = false


func _on_rasa_hitbox_pressed() -> void:
	$RasaDescription.visible = true


func _on_rasa_close_button_pressed() -> void:
	$RasaDescription.visible = false
