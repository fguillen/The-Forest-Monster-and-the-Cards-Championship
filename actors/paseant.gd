class_name Paseant
extends CharacterBody2D

@export var speed = 100
@export var direction = Vector2.RIGHT


func _physics_process(delta):
	velocity = speed * direction
	move_and_slide()
	
	
