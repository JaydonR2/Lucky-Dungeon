extends CharacterBody2D

const SPEED = 300.0

@export var inv: Inv
@onready var health = %Health

func _ready():
	add_to_group("player")
	

func _physics_process(delta):
	var direction = Vector2.ZERO
	var directionHori = Input.get_axis("ui_left", "ui_right")
	var directionVert = Input.get_axis("ui_up", "ui_down")

	# Prioritize one direction if both are pressed
	if directionHori != 0 and directionVert != 0:
		if abs(directionHori) > abs(directionVert):
			directionVert = 0  # Prioritize horizontal
		else:
			directionHori = 0  # Prioritize vertical

	# Set the direction based on the prioritized input
	if directionHori != 0:
		direction.x = directionHori
	if directionVert != 0:
		direction.y = directionVert

	velocity = direction * SPEED
	move_and_slide()

func DecreaseHealth():
	PlayerHealth.health_tracker = PlayerHealth.health_tracker - 0.5
	health.update_health()
	$AnimatedSprite2D.hide()
	$damage.show()
	$damage.play("damage")
	
	
func UpdateHealth():
	health.update_health()

func collect(item):
	inv.insert(item)

#game health test
func _on_area_2d_body_entered(body: Node2D) -> void:
	DecreaseHealth()
# roomR1 health test
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	DecreaseHealth()


func _on_damage_animation_finished() -> void:
	$damage.hide()
	$AnimatedSprite2D.show()
