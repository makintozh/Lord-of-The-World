extends Control










func _process(_delta):
	$Camera2D.position.y = $Scroll.value






#Вход в Таверну
func _on_tavern_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/tavern.tscn")

#Вход в Биомы
func _on_biom_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/biom.tscn")

#Вход в Кланы
func _on_clans_hall_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/clanshall.tscn")

#Вход в Лигу
func _on_league_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/league.tscn")










