extends State

class_name AirState

@export var landing_state : State
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float
@export var jump_animation : String = "jump"
@export var landing_animation : String = "landing"

var has_double_jumped = false

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


func state_process(delta):
	character.velocity.y += get_gravity() * delta
	if(character.is_on_floor()):
		next_state = landing_state

func get_gravity() -> float:
	return jump_gravity if character.velocity.y > 0.0 else fall_gravity
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && !has_double_jumped):
		double_jump()

func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)
		has_double_jumped = false

	
func double_jump():
	character.velocity.y = jump_velocity
	playback.travel(jump_animation)
	has_double_jumped = true

