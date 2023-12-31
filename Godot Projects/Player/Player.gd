extends CharacterBody2D

var health:int = 100

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_controller = get_node("AnimationPlayer")

@onready var animated_sprite = get_node("AnimatedSprite2D")

@onready var health_bar = get_node("../UI/PLAYER HEALTH BAR")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_controller.play("Jump")
		
	if velocity.y > 0:
		animation_controller.play("Fall")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == -1 :
		animated_sprite.flip_h = true
	elif direction == 1:
		animated_sprite.flip_h = false
		
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0 :
			animation_controller.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animation_controller.play("Idle")

	move_and_slide()
	
func damage_player(damage:int = 30):
	health = health - damage
	health_bar.value = health
	print(health)
	#update health bar
	
	if health <= 0:
		get_node("../UI/FAILED SCREEN").visible = true
		self.queue_free()
