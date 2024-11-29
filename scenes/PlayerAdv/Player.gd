extends CharacterBody2D




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")

#player input
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var climb_input = false
var dash_input = false

#Player Movement
var last_direction = Vector2.RIGHT
const SPEED = 70.0
const JUMP_VELOCITY = -400.0

#mechanics
var can_dash = true

#states
var current_state = null
var prev_state = null

@onready var STATES = $STATES
#@onready var Raycasts = $Raycasts

func _ready():
# Will return error if child node does not extend state
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE
	
func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	$StateDebugLabel.text = str(current_state.get_name())
	move_and_slide()
	print("Player velocity" , velocity)
func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta
	#	print("gravity: " , velocity)
		
func change_state(input_state):
	if input_state != null:
		prev_state = current_state 
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("right"):
		movement_input.x += 1
	if Input.is_action_pressed("left"):
		movement_input.x -= 1
	if Input.is_action_pressed("up"):
		movement_input.y -= 1
	if Input.is_action_pressed("down"):
		movement_input.y += 1
	
	#jump
	if Input.is_action_pressed("jump"):
		jump_input = true
	else:
		jump_input = false
	if Input.is_action_just_pressed("jump"):
		jump_input_actuation = true
	else:
		jump_input_actuation = false

	#dash
	if Input.is_action_pressed("dash"):
		dash_input = true
	else:
		dash_input = false

	
	
