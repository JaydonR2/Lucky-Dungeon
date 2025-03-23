extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
	
func _on_options_button_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene_to_file("Options.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
