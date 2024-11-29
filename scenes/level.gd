extends Node2D

@onready var start_position = $StartPosition
@export var character : CharacterBody2D

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_death_zone_body_entered(_body):
	character.velocity = Vector2.ZERO
	character.global_position = start_position.global_position
