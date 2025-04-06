extends Node2D

func _ready():
	var health = $Health
	health.update_health()
	await get_tree().create_timer(1.3).timeout
	$Control/blockLong.position.y -= 216
	$Control/blockShort.position.y -= 216

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
