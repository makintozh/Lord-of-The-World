extends Control




@onready var buttons_control = $Buttons


@onready var player_shaker2D = $PlayerCards/Shaker2D
@onready var enemy_shaker2D = $EnemyCards/Shaker2D


@export var go_duration = 1.0
@export var rotate_duration = go_duration + 0.5
@export var rotate_angle = 25.133



@onready var player_cards = $PlayerCards
@onready var player_card1 = $PlayerCards/Card1
@onready var player_card2 = $PlayerCards/Card2
@onready var player_card3 = $PlayerCards/Card3
@onready var player_card4 = $PlayerCards/Card4
@onready var player_card5 = $PlayerCards/Card5
@onready var player_card6 = $PlayerCards/Card6

@onready var reserve_player_cards = $PlayerCards/ReserveCards
@onready var reserve_player_card1 = $PlayerCards/ReserveCards/Card1
@onready var reserve_player_card2 = $PlayerCards/ReserveCards/Card2
@onready var reserve_player_card3 = $PlayerCards/ReserveCards/Card3
@onready var reserve_player_card4 = $PlayerCards/ReserveCards/Card4



@onready var enemy_cards = $EnemyCards
@onready var enemy_card1 = $EnemyCards/Card1
@onready var enemy_card2 = $EnemyCards/Card2
@onready var enemy_card3 = $EnemyCards/Card3
@onready var enemy_card4 = $EnemyCards/Card4
@onready var enemy_card5 = $EnemyCards/Card5
@onready var enemy_card6 = $EnemyCards/Card6




var player_cards_position = Vector2(0.0, 5.0)
var enemy_cards_position = Vector2(0.0, -500.0)

var easing = Tween.TRANS_CIRC

func start_card():
	var tween = create_tween()
	tween.tween_property(player_cards, "position", player_cards_position, go_duration)
	tween.set_parallel()
	tween.tween_property(player_card1, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(player_card2, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(player_card3, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(player_card4, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(player_card5, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(player_card6, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	tween.tween_property(reserve_player_card1, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(reserve_player_card2, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(reserve_player_card3, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(reserve_player_card4, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	tween.tween_property(enemy_cards, "position", enemy_cards_position, go_duration)
	tween.set_parallel()
	tween.tween_property(enemy_card1, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(enemy_card2, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(enemy_card3, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(enemy_card4, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(enemy_card5, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	tween.tween_property(enemy_card6, "rotation", rotate_angle, rotate_duration).set_trans(easing)
	
	await get_tree().create_timer(rotate_duration - 0.3).timeout
	player_shaker2D.play_shake()
	enemy_shaker2D.play_shake()












func _on_start_pressed() -> void:
		buttons_control.visible = false
		start_card()
