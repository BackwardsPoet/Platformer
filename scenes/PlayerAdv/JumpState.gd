extends State

class_name JumpState

@export var fall_state : State
@export var ground_state : State

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float
@export var jump_animation : String = "jump"
@export var landing_animation : String = "landing"

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func state_process(delta):
	character.gravity(delta)
#	playback.travel(jump_animation)
	if character.velocity.y >0:
		next_state = fall_state
	return fall_state
	if character.is_on_floor():
		next_state = ground_state
		print(character.is_on_floor())
	return fall_state
	
	
func on_enter():
	character.velocity.y = jump_velocity
	if character.velocity.y >0:
		next_state = fall_state
		
func on_exit():
	if character.velocity.y >0:
		next_state = fall_state
