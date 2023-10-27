extends Node


var GOLD: int = 0

var gold = preload("res://Scenes/gold.tscn")

func spawn_gold(position:Vector2):
	var _gold = gold.instantiate()
	_gold.position = position
	add_child(_gold)

func add_gold(gold_to_add:int = 1):
	GOLD = GOLD + 1
	Utils.save_game()
