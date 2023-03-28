class_name Paseant
extends CharacterBody2D

signal scared()

@export var speed = 100
@export var speed_run = 300
@export var direction = Vector2.RIGHT

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var card: Card = $Card

var _current_speed: float


func _ready():
	_current_speed = speed
	_random_card_value()

func _physics_process(delta):
	velocity = _current_speed * direction
	move_and_slide()
	
	
func scare():
	animation_player.play("run")
	_current_speed = speed_run
	emit_signal("scared")
	
	
func _random_card_value():
	var card_value = CardValue.new()
	card_value.attack = randi_range(0, 9)
	card_value.defense = randi_range(0, 9)
	card.setup(card_value)
	
	
	
