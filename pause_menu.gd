extends Control

@onready var main = $"../"

func _on_resume_pressed() -> void:
	main.pauseMenu()
	$InfoPage.hide()
	
func _on_quit_pressed() -> void:
	main.get_tree().paused = false
	$InfoPage.hide()
	GameState.previous_room = ""
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func _on_info_pressed() -> void:
	$InfoPage.show()
