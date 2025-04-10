extends StaticBody2D

@export var item: InvItem

func playercollect(player):
	player.collect(item)

func _on_interactable_area_body_entered(body):
	print("Body entered: ", body.name)
	if body.is_in_group("player"):
		playercollect(body)
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
