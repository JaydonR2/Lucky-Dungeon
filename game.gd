extends Node2D

@onready var Pause_menu = $Pause_menu
var paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("paused"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		Pause_menu.hide()
		get_tree().paused == false
	else:
		Pause_menu.show()
		get_tree().paused == true
	paused = !paused
	
	
