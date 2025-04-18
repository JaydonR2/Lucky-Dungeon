extends CharacterBody2D

var speed = 1
var player_chase = false
var player = null
var touching = false
var health = 1
@onready var player_health = %Health

func _physics_process(delta):
	if player_chase:
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

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

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
