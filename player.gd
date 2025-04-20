extends CharacterBody2D

const SPEED = 300.0

@export var inv: Inv
@onready var health = %Health
@onready var _animated_sprite = $AnimatedSprite2D
var is_attacking = false
var taking_damage = false

func _ready():
	add_to_group("player")
	
func _process(_delta):
	# Handle attack animation
	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		_animated_sprite.play("attack")
		_animated_sprite.connect("animation_finished", _on_animation_finished)
	elif not is_attacking:
		# Default to idle if not moving or attacking
		_animated_sprite.play("idle")

func _physics_process(delta):
	if is_attacking:
		return  # Skip movement while attacking
	if taking_damage:
		return
	
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
		_animated_sprite.flip_h = directionHori < 0  # Flip sprite based on direction
	if directionVert != 0:
		direction.y = directionVert

	velocity = direction * SPEED
	move_and_slide()
	
		
	#if direction != Vector2.ZERO:
	#	_animated_sprite.play("walk")

func _on_animation_finished():
	if _animated_sprite.animation == "attack":
		is_attacking = false
		
func DecreaseHealth():
	PlayerHealth.health_tracker = PlayerHealth.health_tracker - 0.5
	health.update_health()
	taking_damage = true
	$AnimatedSprite2D.hide()
	$damage.show()
	$damage.play("damage")
	
	
	
func UpdateHealth():
	health.update_health()

func collect(item):
	inv.insert(item)

func get_coin_count() -> int:
	var coin_count: int = 0
	if inv:
		for slot in inv.slots:
			if slot.item and slot.item.name == "Coin":
				coin_count += slot.amount
	return coin_count

#game health test
func _on_area_2d_body_entered(body: Node2D) -> void:
	DecreaseHealth()
# roomR1 health test
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	DecreaseHealth()


func _on_damage_animation_finished() -> void:
	$damage.hide()
	taking_damage = false
	$AnimatedSprite2D.show()
