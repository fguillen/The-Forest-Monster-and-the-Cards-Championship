class_name Monster
extends CharacterBody2D

@export var max_speed := 300.0
@export var acceleration := 50.0

@onready var eyes_sprite:Sprite2D = $EyesSprite
@onready var body_sprite:Sprite2D = $BodySprite


var _state = "idle"

func _physics_process(delta):
	# Move
	var direction = Input.get_axis("ui_left", "ui_right")
	var max_velocity = Vector2(direction * max_speed, 0)
	velocity = velocity.lerp(max_velocity, acceleration * delta)
	move_and_slide()
	
	# Hide
	if Input.is_action_just_pressed("ui_up"):
		_set_state_hidden()
		
	# Unhide
	if Input.is_action_just_pressed("ui_down"):
		_set_state_idle()
		

func _set_state_hidden():
	_state = "hidden"
	body_sprite.visible = false
	eyes_sprite.visible = true


func _set_state_idle():
	_state = "idle"
	body_sprite.visible = true
	eyes_sprite.visible = false
