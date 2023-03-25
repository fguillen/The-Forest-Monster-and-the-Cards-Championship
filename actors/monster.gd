class_name Monster
extends CharacterBody2D

@export var max_speed := 300.0
@export var acceleration := 50.0

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	var max_velocity = Vector2(direction * max_speed, 0)
	velocity = velocity.lerp(max_velocity, acceleration * delta)

	move_and_slide()
