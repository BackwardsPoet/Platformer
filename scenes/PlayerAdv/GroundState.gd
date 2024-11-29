extends State

class_name GroundState

@export var jump_state : State
@export var fall_state : State
@export var run_state : State
@export var dash_state : State
@export var jump_input_actuation = false

@export var ground_state : State

func state_process(delta):
	if character.velocity.y >0:
		next_state = fall_state
		
func state_input(event : InputEvent): 
	if(event.is_action_pressed("jump")):
		jump_input_actuation = true
	if jump_input_actuation:
		next_state = jump_state		
	if character.velocity.y >0:
		next_state = fall_state		
	
func on_enter():
	next_state = ground_state
	print("Ground State")
