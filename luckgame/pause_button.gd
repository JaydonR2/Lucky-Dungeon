extends Control

@onready var main = $"../"

func show_play():
	$pause.hide()
	$play.show()
	
func show_pause():
	$play.hide()
	$pause.show()

func _on_play_pressed() -> void:
	main.pauseMenu()
	show_pause()
