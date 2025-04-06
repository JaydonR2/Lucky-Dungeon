extends Node2D

var is_open = false
@export var loot: Array[String] = ["Gold", "Potion"]

func give_loot(player):
	for item in loot:
		player.add_to_inventory(item)  # Implement inventory system


func _on_hitbox_body_entered(body):
	is_open = true
	$AnimatedSprite2D.play("open")  # Play chest opening animation
	#give_loot(body)
