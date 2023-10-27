extends Node2D

func _on_body_entered(body):
	if body.name == "Player":
		GameManager.add_gold(1)
		var tween = get_tree().create_tween()
		var tween_gold = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		tween_gold.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)
