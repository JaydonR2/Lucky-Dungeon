extends Node2D

var is_open = false
@export var loot: Array[String] = ["Gold", "Potion"]
var rng: RandomNumberGenerator
func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
func _on_hitbox_body_entered(body):
	if (is_open == false):
		is_open = true
		$AnimatedSprite2D.play("open")  # Play chest opening animation
		#give_loot(body)
		var CoinScene := preload("res://inventory/items/coin.tscn")
		var amount: int = rng.randi_range(0, 5)
		for i in amount:
			var coin = CoinScene.instantiate()
			coin.global_position = global_position
			get_tree().current_scene.add_child(coin)
		
func give_loot(player):
	for item in loot:
		player.add_to_inventory(item)  # Implement inventory system
