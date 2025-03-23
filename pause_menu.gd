extends Control

@onready var main = $"../"

func _on_resume_pressed() -> void:
	main.pauseMenu()
	
func _on_load_pressed() -> void:
	main.load_game()
	main.pauseMenu()
	
func _on_quit_pressed() -> void:
	main.get_tree().paused = false
	get_tree().change_scene_to_file("res://menu/menu.tscn")
