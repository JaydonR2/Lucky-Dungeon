extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("paused"):
		pauseMenu()
		
func _ready():
	var player = $Player
	if GameState.previous_room == "RoomR1U1":
		var spawn = $SpawnR1U1
		player.global_position = spawn.global_position
	if GameState.previous_room == "StartRoom":
		var spawn = $SpawnStart
		player.global_position = spawn.global_position
	if GameState.previous_room == "RoomR2":
		var spawn = $SpawnR2
		player.global_position = spawn.global_position
	var health = $Health
	health.update_health()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameState.previous_room = "RoomR1"
		call_deferred("_change_scene")

func _change_scene():
	get_tree().change_scene_to_file("res://game.tscn")


func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameState.previous_room = "RoomR1"
		call_deferred("_change_sceneR1U1")
	
func _change_sceneR1U1():
	get_tree().change_scene_to_file("res://Rooms/RoomR1U1.tscn")
	

func _on_area_2d_4_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameState.previous_room = "RoomR1"
		call_deferred("_change_sceneR2")

func _change_sceneR2():
	get_tree().change_scene_to_file("res://Rooms/RoomR2.tscn")

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
	
