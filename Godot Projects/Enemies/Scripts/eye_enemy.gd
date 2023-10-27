extends CharacterBody2D

@export var bounds = Vector2() 

var bound_limit = 50

var SPEED = 80

var go_up = true

var is_dead:bool = false

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(is_dead):
		return
	
	var upper_bound = position.y - bound_limit
	var lower_bound = position.y + bound_limit
	
	if position.y < bounds.x:
		go_up = false
		
	elif position.y > bounds.y:
		go_up = true
	
	if go_up:
		position.y -= SPEED * delta
	else:
		position.y += SPEED * delta

func die():
	is_dead = true
	animated_sprite.play("Death")
	await animated_sprite.animation_finished
	self.queue_free()

func _on_enemy_damage_player_collider_body_entered(body):
	if body.name == "Player":
		body.damage_player(15)

func _on_enemy_death_collider_body_entered(body):
	if body.name == "Player":
		die()
		GameManager.spawn_gold(self.position)
