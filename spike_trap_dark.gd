extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.DecreaseHealth()
		$TextureRect2.visible = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$TextureRect2.visible = false
