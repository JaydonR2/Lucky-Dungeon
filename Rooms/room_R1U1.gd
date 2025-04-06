extends Node2D

func _ready():
	var player = $Player
	if GameState.previous_room == "RoomR1":
		var spawn = $SpawnR1
		player.global_position = spawn.global_position
	if GameState.previous_room == "RoomU1":
		var spawn = $SpawnU1
		player.global_position = spawn.global_position
	var health = $Health
	health.update_health()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameState.previous_room = "RoomR1U1"
		call_deferred("_change_sceneRoomU1")

func _change_sceneRoomU1():
	get_tree().change_scene_to_file("res://Rooms/RoomU1.tscn")


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameState.previous_room = "RoomR1U1"
		call_deferred("_change_sceneRoomR1")

func _change_sceneRoomR1():
	get_tree().change_scene_to_file("res://Rooms/RoomR1.tscn")
	
var paused = false
@onready var pause_button = $pause_button
@onready var Pause_menu = $Pause_menu

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
