class_name PlayerStateRun extends PlayerState

@export var move_speed: float = 100

# stato inizializzato
func init() -> void:
	pass

# entro nello stato
func enter() -> void:
	# play animation
	pass

# esco dallo stato
func exit() -> void:
	pass

# quando premo un input
func handle_input( _event : InputEvent ) -> PlayerState:
	# handle input
	return next_state


func process(_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * move_speed
	return next_state
