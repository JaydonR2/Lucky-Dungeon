extends Node2D

var is_open = false
@export var loot: Array[String] = ["Gold", "Potion"]

func _on_body_entered(body):
	if body.name == "Player" and not is_open:
		is_open = true
		$AnimationPlayer.play("open")  # Play chest opening animation
		give_loot(body)

func give_loot(player):
	for item in loot:
		player.add_to_inventory(item)  # Implement inventory system
