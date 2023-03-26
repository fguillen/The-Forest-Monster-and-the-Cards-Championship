class_name Paseant
extends CharacterBody2D

@export var speed = 100
@export var speed_run = 300
@export var direction = Vector2.RIGHT

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _current_speed: float


func _ready():
	_current_speed = speed

func _physics_process(delta):
	velocity = _current_speed * direction
	move_and_slide()
	
	
func scare():
	animation_player.play("run")
	_current_speed = speed_run
	
	
