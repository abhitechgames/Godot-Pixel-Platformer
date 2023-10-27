extends CharacterBody2D

@export var bounds = Vector2() 

var bound_limit = 50

var SPEED = 80

var go_right = false

@onready var animated_sprite = $AnimatedSprite2D

var is_dead:bool = false

func _ready():
	animated_sprite.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(is_dead):
		return
	
	var upper_bound = position.x - bound_limit
	var lower_bound = position.x + bound_limit
	
	if position.x < bounds.x:
		go_right = true
		animated_sprite.flip_h = true
		
	elif position.x > bounds.y:
		go_right = false
		animated_sprite.flip_h = false
	
	if go_right:
		position.x += SPEED * delta
	else:
		position.x -= SPEED * delta

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
