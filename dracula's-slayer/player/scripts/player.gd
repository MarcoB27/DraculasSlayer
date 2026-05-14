class_name Player extends CharacterBody2D

#region --- state machine variables
var states : Array[ PlayerState ]
var current_state : PlayerState :
	get : return states.front() # ritorna il primo elemento dell'array
var previous_state : PlayerState :
	get : return states[1]
#endregion

#region --- standard variables
var direction : Vector2 = Vector2.ZERO

var gravity : float = 980

#endregion

func _ready() -> void:
	initialize_states()
	pass


func _process(_delta: float) -> void:
	upgrade_function()
	change_state(current_state.process(_delta))
	pass

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	pass

func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta
	move_and_slide()
	change_state(current_state.physics_process(_delta))
	
	pass


func initialize_states():
	states = []
	# raccogliere stati
	for c in $States.get_children():		# prende tutti i nodi figli del nodo States
		if c is PlayerState:
			states.append(c)
			c.player = self
		pass
	
	if states.size() == 0:
		return
	
	# inizializzare stati
	for state in states:
		state.init()
		pass
	
	# settare stati
	change_state(current_state)
	current_state.enter()
	pass


func change_state(new_state : PlayerState) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	states.push_front(new_state)
	current_state.enter()
	
	states.resize(3)
	pass

func upgrade_function() -> void:
	var prev_direction : Vector2 = direction
	
	var x_axys = Input.get_axis("left", "right")
	var y_axys = Input.get_axis("up", "down")
	direction = Vector2(x_axys, y_axys)
	
	
	pass
