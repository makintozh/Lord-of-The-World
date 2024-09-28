extends Control






func _ready():
	$PlayerGui.navigation.visible = false
	$PlayerGui.actions.visible = false
	
	_on_klassgold_pressed()
	_on_alliancegold_pressed()
	_on_rasagold_pressed()






func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_back_button_pressed()



#Если нажата стрелочка "Назад"
func _on_back_button_pressed():
	SceneManager.go_to_scene("res://src/scenes/game-scenes/tavern.tscn")



func _on_klassdefault_pressed() -> void:
	$Control/klassdefault.visible = false
	$Control/Klassgold.visible = true


func _on_klassgold_pressed() -> void:
	$Control/klassdefault.visible = true
	$Control/Klassgold.visible = false


func _on_alliancedefault_pressed() -> void:
	$Control/alliancedefault.visible = false
	$Control/alliancegold.visible = true


func _on_alliancegold_pressed() -> void:
	$Control/alliancedefault.visible = true
	$Control/alliancegold.visible = false


func _on_rasadefault_pressed() -> void:
	$Control/rasadefault.visible = false
	$Control/rasagold.visible = true


func _on_rasagold_pressed() -> void:
	$Control/rasadefault.visible = true
	$Control/rasagold.visible = false
