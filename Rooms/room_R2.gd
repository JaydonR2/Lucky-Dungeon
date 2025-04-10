extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("paused"):
		pauseMenu()
func _ready():
	var health = $Health
	health.update_health()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameState.previous_room = "RoomR2"
		call_deferred("_change_sceneRoomR1")

func _change_sceneRoomR1():
	get_tree().change_scene_to_file("res://Rooms/RoomR1.tscn")

@onready var pause_button = $pause_button
@onready var Pause_menu = $Pause_menu
var paused = false

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
