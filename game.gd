extends Node2D

@onready var pause_button = $pause_button
@onready var Pause_menu = $Pause_menu
var paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("paused"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		Pause_menu.hide()
		pause_button.show_play()
		get_tree().paused == false
		
	else:
		Pause_menu.show()
		pause_button.show_pause()
		get_tree().paused == true
	paused = !paused
	
	


func _on_reset_pressed() -> void:
	get_tree().reload_current_scene()
