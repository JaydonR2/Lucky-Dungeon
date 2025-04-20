extends CharacterBody2D

var speed = 1
var player_chase = false
var boss_aggro = false
var player = null
var touching = false
var health = 5
var coinThreshold = 1
@onready var player_health = %Health

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)

func _physics_process(delta):
	$AnimatedSprite2D.flip_h=true
	if player_chase and boss_aggro:
		if position.distance_to(player.position) > 10:
			position += (player.position - position).normalized() * speed
			$AnimatedSprite2D.play("idle")
			if (player.position.x-position.x)<0:
				$AnimatedSprite2D.flip_h=true
			else:
				$AnimatedSprite2D.flip_h=false
		if position.distance_to(player.position) < 2:
			position = position - (player.position - position).normalized() * speed
			$AnimatedSprite2D.play("idle")
			if (player.position.x-position.x)<0:
				$AnimatedSprite2D.flip_h=true
			else:
				$AnimatedSprite2D.flip_h=false
	move_and_slide()

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func DialogicSignal(arg: String):
	if arg == "coin_option":
		if player:  # Check if player reference is valid
			var coin_count: int = player.get_coin_count()
			print("Coin Count:", coin_count)
			print("Coin Threshold:", coinThreshold)
			if coin_count >= coinThreshold:
				print("Player has enough coins!")
				boss_aggro = false
				queue_free()  # Or any other action
			else:
				print("Player does not have enough coins.")
				boss_aggro = true
	if arg == "battle_option":
		boss_aggro = true

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	
	if !boss_aggro:
		run_dialogue("BossDialogue")

func _on_detection_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	player = null
	player_chase = false

func _on_hitbox_body_entered(body):
	touching = true
	PlayerHealth.health_tracker = PlayerHealth.health_tracker - 0.5
	player_health.update_health()
	await get_tree().create_timer(1.0).timeout
	if (touching != false):
		_on_hitbox_body_entered(body)

func _on_hitbox_body_exited(body):
	touching = false
