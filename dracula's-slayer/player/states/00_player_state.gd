@icon("res://player/states/draculaIcon.svg")

class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region --- state references
# reference to all other states 
#endregion

# stato inizializzato
func init() -> void:
	pass

# entro nello stato
func enter() -> void:
	pass

# esco dallo stato
func exit() -> void:
	pass

# quando premo un input
func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state


func process(_delta: float) -> PlayerState:
	return next_state

func physics_process(_delta: float) -> PlayerState:
	return next_state
