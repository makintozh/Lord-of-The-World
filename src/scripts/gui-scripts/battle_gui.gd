extends Control




@onready var buttons_control = $Buttons


@onready var shaker2D = $Shaker2D




@onready var player_cards:Node = $PlayerCards
@onready var player_card1:Node = $PlayerCards/Card1
@onready var player_card2:Node = $PlayerCards/Card2
@onready var player_card3:Node = $PlayerCards/Card3
@onready var player_card4:Node= $PlayerCards/Card4
@onready var player_card5:Node = $PlayerCards/Card5
@onready var player_card6:Node= $PlayerCards/Card6


var position_player_card_1 : Vector2 = Vector2(69.0, 604.0)
var position_player_card_2 : Vector2 = Vector2(205.0, 609.0)
var position_player_card_3 : Vector2 = Vector2(341.0, 604.0)
var position_player_card_4 : Vector2 = Vector2(69.0, 750.0)
var position_player_card_5 : Vector2 = Vector2(205.0, 760.0)
var position_player_card_6 : Vector2 = Vector2(341.0, 750.0)



@onready var reserve_player_cards:Node = $PlayerCards/ReserveCards
@onready var reserve_player_card1:Node = $PlayerCards/ReserveCards/Card1
@onready var reserve_player_card2:Node = $PlayerCards/ReserveCards/Card2
@onready var reserve_player_card3:Node = $PlayerCards/ReserveCards/Card3
@onready var reserve_player_card4:Node = $PlayerCards/ReserveCards/Card4



@onready var enemy_cards:Node = $EnemyCards
@onready var enemy_card1:Node = $EnemyCards/Card1
@onready var enemy_card2:Node = $EnemyCards/Card2
@onready var enemy_card3:Node = $EnemyCards/Card3
@onready var enemy_card4:Node = $EnemyCards/Card4
@onready var enemy_card5:Node = $EnemyCards/Card5
@onready var enemy_card6:Node = $EnemyCards/Card6



var position_enemy_card_1 : Vector2 = Vector2(69.0, 87.0)
var position_enemy_card_2 : Vector2 = Vector2(205.0, 77.0)
var position_enemy_card_3 : Vector2 = Vector2(341.0, 87.0)
var position_enemy_card_4 : Vector2 = Vector2(69.0, 245.0)
var position_enemy_card_5 : Vector2 = Vector2(205.0, 235.0)
var position_enemy_card_6 : Vector2 = Vector2(341.0, 245.0)



var reserve_player_cards_position = Vector2(109.0, 905.0)


var top_gate : Vector2 = Vector2(209.0,-200.0)
var down_gate : Vector2 = Vector2(209.0,1400.0)


var easing = Tween.TRANS_LINEAR

var time_across = 0.1


@export var go_duration = 0.2
@export var rotate_duration = go_duration + 0.5
@export var rotate_angle = 12.566



func start_card():
	var tween = create_tween().set_parallel(true).set_speed_scale(1.5)
	
	
	tween.tween_property(player_card1, "position", down_gate, go_duration).set_trans(easing)
	tween.tween_property(player_card1, "position", position_player_card_1, go_duration).set_trans(easing)
	tween.tween_property(player_card1, "rotation", rotate_angle, rotate_duration).set_trans(easing)

	tween.tween_property(player_card2, "position", down_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(player_card2, "position", position_player_card_2, go_duration).set_trans(easing)
	tween.tween_property(player_card2, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	tween.tween_property(player_card3, "position", down_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(player_card3, "position", position_player_card_3, go_duration).set_trans(easing)
	tween.tween_property(player_card3, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	tween.tween_property(player_card4, "position", down_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(player_card4, "position", position_player_card_4, go_duration).set_trans(easing)
	tween.tween_property(player_card4, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	tween.tween_property(player_card5, "position", down_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(player_card5, "position", position_player_card_5, go_duration).set_trans(easing)
	tween.tween_property(player_card5, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	tween.tween_property(player_card6, "position", down_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(player_card6, "position", position_player_card_6, go_duration).set_trans(easing)
	tween.tween_property(player_card6, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	
	tween.chain().tween_property(reserve_player_cards, "position", reserve_player_cards_position, go_duration).set_trans(easing)
	tween.tween_property(reserve_player_card1, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(reserve_player_card2, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(reserve_player_card3, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(reserve_player_card4, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	
	
	
	tween.chain().tween_property(enemy_card1, "position", top_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(enemy_card1, "position", position_enemy_card_1, go_duration).set_trans(easing)
	tween.tween_property(enemy_card1, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	tween.tween_property(enemy_card2, "position", top_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(enemy_card2, "position", position_enemy_card_2, go_duration).set_trans(easing)
	tween.tween_property(enemy_card2, "rotation", rotate_angle, rotate_duration).set_trans(easing)

	tween.tween_property(enemy_card3, "position", top_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(enemy_card3, "position", position_enemy_card_3, go_duration).set_trans(easing)
	tween.tween_property(enemy_card3, "rotation", rotate_angle, rotate_duration).set_trans(easing)

	tween.tween_property(enemy_card4, "position", top_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(enemy_card4, "position", position_enemy_card_4, go_duration).set_trans(easing)
	tween.tween_property(enemy_card4, "rotation", rotate_angle, rotate_duration).set_trans(easing)

	tween.tween_property(enemy_card5, "position", top_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(enemy_card5, "position", position_enemy_card_5, go_duration).set_trans(easing)
	tween.tween_property(enemy_card5, "rotation", rotate_angle, rotate_duration).set_trans(easing)

	tween.tween_property(enemy_card6, "position", top_gate, go_duration).set_trans(easing)
	tween.chain().tween_property(enemy_card6, "position", position_enemy_card_6, go_duration).set_trans(easing)
	tween.tween_property(enemy_card6, "rotation", rotate_angle, rotate_duration).set_trans(easing)



	
	#await get_tree().create_timer(rotate_duration - 0.3).timeout
	#player_shaker2D.play_shake()
	#enemy_shaker2D.play_shake()




var move_duration = 0.3
var across_move_time = 4

var normal_scale : Vector2 = Vector2(1.0 , 1.0)
var small_scale : Vector2 = Vector2(0.8 , 0.8)
var scale_duration = 0.3

func move_card(card:Node, to_card_position:Vector2):
	#var node2D = card.get_child(0)
	#shaker2D.reparent(node2D)
	#await get_tree().create_timer(0.1).timeout 
	#shaker2D.duration = move_duration + 0.1
	#shaker2D.play_shake()
	
	await get_tree().create_timer(0.3)
	var original_card_position = card.position
	card.z_index = 1
	
	
	var tween = create_tween()
	tween.tween_property(card, "scale", small_scale, scale_duration)
	tween.tween_property(card, "scale", normal_scale, scale_duration)
	tween.tween_property(card, "position", to_card_position, move_duration)
	tween.chain().tween_property(card, "position", original_card_position, move_duration).set_delay(0.1)


func mover():
	move_card(player_card5, position_enemy_card_2)
	await get_tree().create_timer(across_move_time).timeout
	
	move_card(player_card5, position_enemy_card_1)
	await get_tree().create_timer(across_move_time).timeout
	
	move_card(player_card5, position_enemy_card_3)
	await get_tree().create_timer(across_move_time).timeout
	
	move_card(player_card5, position_enemy_card_5)
	await get_tree().create_timer(across_move_time).timeout
	
	move_card(player_card5, position_enemy_card_4)
	await get_tree().create_timer(across_move_time).timeout
	
	move_card(player_card5, position_enemy_card_6)





func _on_start_pressed() -> void:
		buttons_control.visible = false
		start_card()


func _on_button_pressed() -> void:
	mover()
