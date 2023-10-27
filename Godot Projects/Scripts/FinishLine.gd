extends Node2D

func _on_finish_2d_body_entered(body):
	if body.name == "Player":
		get_node("../UI/WIN SCREEN").visible = true
		get_node("../Player").queue_free()
