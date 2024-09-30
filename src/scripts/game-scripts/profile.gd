extends Control




@onready var player_name = $PlayerCardDesign/PlayerName/PlayerName/PlayerNameLabel

var is_element_window_opened:bool = false
var button_click_count:int = 0



func _ready():
	_on_close_button_pressed()
	_on_class_close_button_pressed()
	_on_rasa_close_button_pressed()
	$CardSkills/ChangeWindow.visible = false
	$EquipedElement.visible = false
	$UnEquipedElement.visible = false
	$StylesWindow.visible = false
	$ChangeCard.visible = false
	$ChangeCard/Info_ChangeCard.visible = false
	$CardEquipment/EquipElements/WeaponWindow.visible = false
	$LearnedSkillClicked.visible = false
	$PresetsWindow.visible = false
	$UnLearnedSkillClicked.visible = false
	$PlayerGui.navigation.visible = false
	$PlayerGui.actions.visible = false
	$ChatGui._on_hide_chat_pressed()
	
	
	player_name.text = GLOBAL.player_character_name



func _process(_delta: float) -> void:
	if is_element_window_opened:
		$CloseElementHitBox.visible = true
		$CloseElementHitBox2.visible = true
	else:
		$CloseElementHitBox.visible = false
		$CloseElementHitBox2.visible = false



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


func _on_weapon_element_button_pressed() -> void:
	$CardSkills/ChangeWindow.visible = false
	is_element_window_opened = true
	$CardEquipment/EquipElements/WeaponWindow.visible = true


func _on_close_element_hit_box_pressed() -> void:
	if is_element_window_opened:
		is_element_window_opened = false
		$CardEquipment/EquipElements/WeaponWindow.visible = false


func _on_change_skill_pressed() -> void:
	button_click_count += 1
	if button_click_count < 2:
		$CardSkills/ChangeWindow.visible = true

	elif button_click_count == 2:
		button_click_count = 0
		$CardSkills/ChangeWindow.visible = false


func _on_learned_skill_hitbox_pressed() -> void:
	$LearnedSkillClicked.visible = true



func _on_learned_close_pressed() -> void:
	$LearnedSkillClicked.visible = false
	$UnLearnedSkillClicked.visible = false
	$EquipedElement.visible = false
	$StylesWindow.visible = false
	$PresetsWindow.visible = false
	$PlayerCardDesign.visible = true
	$CardFunctional.visible = true
	$CardParameter.visible = true
	$CardSkills.visible = true
	$CardEquipment.visible = true
	$ProfileResources.visible = true
	$ChangeCard.visible = false
	_on_change_skill_pressed()


func _on_choice_pressed() -> void:
	$LearnedSkillClicked.visible = false
	$UnLearnedSkillClicked.visible = false
	$UnEquipedElement.visible = false


func _on_un_learned_skill_clicked_pressed() -> void:
	$UnLearnedSkillClicked.visible = true



func _on_hands_element_pressed() -> void:
	$EquipedElement.visible = true




func _on_equiped_weapon_pressed() -> void:
	$EquipedElement.visible = true


func _on_change_button_pressed() -> void:
	$PlayerCardDesign.visible = false
	$CardFunctional.visible = false
	$CardParameter.visible = false
	$CardSkills.visible = false
	$CardEquipment.visible = false
	$ProfileResources.visible = false
	$ChangeCard.visible = true




func _on_style_button_pressed() -> void:
	$StylesWindow.visible = true


func _on_info_hit_box_pressed() -> void:
	$ChangeCard/Info_ChangeCard.visible = true


func _on_info_close_pressed() -> void:
	$ChangeCard/Info_ChangeCard.visible = false


func _on_preset_button_pressed() -> void:
	$PlayerCardDesign.visible = false
	$CardFunctional.visible = false
	$CardParameter.visible = false
	$CardSkills.visible = false
	$CardEquipment.visible = false
	$ProfileResources.visible = false
	$PresetsWindow.visible = true
