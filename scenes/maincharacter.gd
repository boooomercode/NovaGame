extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -600.0

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"
	else:
		# If on floor → choose between running or idle
		if velocity.x == 0:
			sprite_2d.animation = "default"
		else:
			sprite_2d.animation = "running"

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite_2d.animation = "jumping"

	# Movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 100)

	move_and_slide()

	# Flip sprite
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0
