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
		get_tree().paused = false
		
	else:
		Pause_menu.show()
		pause_button.show_pause()
		get_tree().paused = true
	paused = !paused
	
	


func _ready():
	var player = $Player
	if GameState.previous_room == "RoomR1":
		var spawn = $Spawnright
		player.global_position = spawn.global_position
	if GameState.previous_room == "RoomU1":
		var spawn = $Spawnup
		player.global_position = spawn.global_position
func save_game():
	print("Saving...")
	var player = get_node_or_null("Player")
	print("Player node:", player)
	if player:
		var save_data = {
			"player_position": player.global_position
		}
		var file = FileAccess.open("user://save_game.save", FileAccess.WRITE)
		if file:
			file.store_var(save_data)
			file.close()
			print("✅ Game saved!", save_data)
		else:
			print("❌ Save failed to open file.")
	else:
		print("❌ Player not found in save_game().")

func load_game():
	if FileAccess.file_exists("user://save_game.save"):
		var file = FileAccess.open("user://save_game.save", FileAccess.READ)
		if file:
			var save_data = file.get_var()
			file.close()

			var player = get_node_or_null("Player")
			if player:
				player.global_position = save_data.get("player_position", player.global_position)
				print("✅ Game loaded!", save_data)
			else:
				print("❌ Player not found in load_game().")
		else:
			print("❌ Failed to open save file.")
	else:
		print("⚠️ No save file found.")

func _on_reset_pressed() -> void:
	GameState.previous_room = ""
	get_tree().reload_current_scene()


func _on_save_icon_pressed() -> void:
	save_game() # Replace with function body.
