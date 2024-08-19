extends Control








#Вход в Таверну
func _on_tavern_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/game-scenes/tavern.tscn")

#Вход в Биомы
func _on_biom_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/game-scenes/biom.tscn")

#Вход в Кланы
func _on_clans_hall_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/game-scenes/clanshall.tscn")

#Вход в Лигу
func _on_league_pressed():
	SceneChangeManager.go_to_scene("res://src/scenes/game-scenes/league.tscn")










