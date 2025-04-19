# Healing Slime
extends CharacterBody2D
var speed = .5
var player_chase = false
var player = null
var touching = false
var health = 1
@onready var player_health = get_tree().current_scene.get_node("Health")
func _ready():
	$AnimatedSprite2D.modulate = Color(1.0, 0.4, 0.7)

func _physics_process(delta):
	if player_chase:
		if position.distance_to(player.position) > 10:
			position += (player.position - position).normalized() * speed
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
	PlayerHealth.health_tracker += 0.5
	PlayerHealth.health_tracker = clamp(PlayerHealth.health_tracker, 0.0, 3.0)
	player_health.update_health()
	await get_tree().create_timer(1.0).timeout
	if (touching != false):
		_on_hitbox_body_entered(body)

func _on_hitbox_body_exited(body):
	touching = false
