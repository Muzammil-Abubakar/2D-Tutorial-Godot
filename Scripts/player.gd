extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const COYOTE_TIME = 0.15
const JUMP_BUFFER_TIME = 0.15

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D

var coyote_timer = 0.0
var jump_buffer_timer = 0.0
var can_double_jump = true

func _physics_process(delta):
	# Timers
	if coyote_timer > 0:
		coyote_timer -= delta
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	# Check if on floor to reset coyote timer and double jump
	if is_on_floor():
		coyote_timer = COYOTE_TIME
		can_double_jump = true

	# Jump buffer input
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = JUMP_BUFFER_TIME

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump Logic
	if jump_buffer_timer > 0:
		if coyote_timer > 0:
			# Normal jump
			velocity.y = JUMP_VELOCITY
			jump_buffer_timer = 0
			coyote_timer = 0
		elif can_double_jump:
			# Double jump
			velocity.y = JUMP_VELOCITY
			jump_buffer_timer = 0
			can_double_jump = false

	# Horizontal Movement
	var direction = Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	# Animation
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")  # Same animation for both jumps

	# Horizontal velocity
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
