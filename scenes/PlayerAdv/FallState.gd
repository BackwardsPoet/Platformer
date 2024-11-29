extends State

class_name FallState

@export var landing_animation_name : String = "fall"
@export var ground_state : State

func on_enter():
	if character.is_on_floor():
		next_state = ground_state
func state_process(delta):
	character.gravity(delta)
	if character.is_on_floor():
		print(character.is_on_floor())
		next_state = ground_state


func on_exit():
	if character.is_on_floor():
		next_state = ground_state
