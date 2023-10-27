extends Node2D



func _on_body_entered(body):
	if body.name == "Player":
		body.damage_player(150)
