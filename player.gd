extends CharacterBody2D

const SPEED = 300.0

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
