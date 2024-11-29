extends CharacterBody2D

const speed : float = 130.0


@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

var direction : Vector2 = Vector2.ZERO
var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_input = false
var jump_input_actuation = false
var dash_input = false

func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	player_input()
	gravity(delta)
	direction =  Input.get_vector("left", "right", "up", "down")
	#Control to move
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	print(is_on_floor())
	
func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta
#print("Gravity: " , velocity)

	
func player_input():
	#jump
	if Input.is_action_pressed("jump"):
		jump_input = true
	else: jump_input = false
	if Input.is_action_just_pressed("jump"):
		jump_input_actuation = true
	else: jump_input_actuation = false	
	
	#dash
	if Input.is_action_pressed("dash"):
		dash_input = true
	else:
		dash_input = false	
func update_animation_parameters():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
