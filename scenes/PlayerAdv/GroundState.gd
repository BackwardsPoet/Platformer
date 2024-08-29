extends State

class_name GroundState
@export var jump_height : float
@export var jump_time_to_peak : float
@export var air_state : State
@export var jump_animation : String = "jump"

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent): 
	if(event.is_action_pressed("jump")):
		jump()

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

	
