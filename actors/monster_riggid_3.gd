class_name Monster
extends CharacterBody2D

@export var max_speed := 100.0
@export var acceleration := 50.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer


var _state = "idle"

func _ready():
	_set_state_idle()
	

func _physics_process(delta):
	# Move if not scaring
	if not _state == "scare":
		var direction = Input.get_axis("ui_left", "ui_right")
		var max_velocity = Vector2(direction * max_speed, 0)
		velocity = velocity.lerp(max_velocity, acceleration * delta)
		move_and_slide()
		if direction:
			_set_state_walk()
		else:
			_set_state_idle()
	
	# Hide
	if Input.is_action_just_pressed("ui_up"):
		_set_state_hidden()
		
	# Unhide
	if Input.is_action_just_pressed("ui_down"):
		_set_state_idle()
		
	# Scare
	if Input.is_action_just_pressed("ui_accept"):
		_set_state_scare()
		

func _set_state_hidden():
	_state = "hidden"
#	animation_player.play("hidden")


func _set_state_idle():
	_state = "idle"
	animation_player.play("idle")
	
	
func _set_state_walk():
	_state = "walk"
	animation_player.play("walk")


func _set_state_scare():
	_state = "scare"
	animation_player.play("scare")


func _on_animation_player_animation_finished(anim_name):
	if _state == "scare":
		_set_state_idle()


func _on_scare_area_2d_body_entered(body):
	if body is Paseant:
		body.scare()
