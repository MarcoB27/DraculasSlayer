extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const LOW_JUMP_MULTIPLIER = 0.5

@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var was_on_floor := false
var can_use_coyote := false
var jump_buffered := false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	# Flip Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# if you just left the floor, start coyote time
	if not is_on_floor() and was_on_floor and velocity.y >= 0:
		can_use_coyote = true
		coyote_timer.start()
		
	# if you land and you had jumo on buffer, start jumping
	if is_on_floor() and jump_buffered:
		do_jump()
		
	was_on_floor = is_on_floor()
	
func do_jump() -> void:
	velocity.y = JUMP_VELOCITY
	can_use_coyote = false
	jump_buffered = false
	coyote_timer.stop()
	jump_buffer_timer.stop()


func _on_jump_buffer_timer_timeout() -> void:
	jump_buffered = false

func _on_coyote_timer_timeout() -> void:
	can_use_coyote = false
	
