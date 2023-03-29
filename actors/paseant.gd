class_name Paseant
extends CharacterBody2D

signal scared()

@export var speed = 100
@export var speed_run = 300
@export var speed_back = 125
@export var direction = Vector2.RIGHT

@export var colors_skin: Array[Color]
@export var colors_clothe: Array[Color]

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var card: Card = $Card

@onready var _clothe_sweeter = [$Polygons/ArmLeft, $Polygons/ArmRight, $Polygons/Body]
@onready var _clothe_pans = [$Polygons/LegLeft, $Polygons/LegRight]
@onready var _clothe_shoes = [$Polygons/FootLeft, $Polygons/FootRight]
@onready var _clothe_skin = [$Polygons/Head, $Polygons/HandLeft, $Polygons/HandRight]


var _current_speed: float


func _ready():
	_set_default_colors()
	_set_random_clothe_colors()
	_current_speed = speed
	_random_card_value()


func _process(delta):
	_check_if_should_be_destroyed()


func _physics_process(delta):
	velocity = _current_speed * direction
	move_and_slide()
	
	
func scare():
	animation_player.play("run")
	_current_speed = speed_run
	emit_signal("scared")
	
	
func walk_back():
	animation_player.play("walk_back")
	_current_speed = speed_back
	direction = Vector2.LEFT
	emit_signal("walk_back")
	
	
func _random_card_value():
	var card_value = CardValue.new()
	card_value.attack = randi_range(0, 9)
	card_value.defense = randi_range(0, 9)
	card.setup(card_value)
	
	
func _set_default_colors():
	if colors_skin.is_empty():
		colors_skin = [Color.html("#867070"), Color.html("#D5B4B4"), Color.html("#E4D0D0"), Color.html("#F5EBEB")]
	
	if colors_clothe.is_empty():
		colors_clothe = [
			Color.html("#BBD6B8"),
			Color.html("#AEC2B6"),
			Color.html("#94AF9F"),
			Color.html("#DBE4C6"),
			Color.html("#CCD5AE"),
			Color.html("#E9EDC9"),
			Color.html("#FEFAE0"),
			Color.html("#FAEDCD"),
			Color.html("#8D7B68"),
			Color.html("#A4907C"),
			Color.html("#C8B6A6"),
			Color.html("#F1DEC9"),
		]


		
func _set_random_clothe_colors():
	var color_sweeter = colors_clothe.pick_random()
	for i in _clothe_sweeter:
		i.color = color_sweeter
		
	var color_pans = colors_clothe.pick_random()
	for i in _clothe_pans:
		i.color = color_pans
		
	var color_skin = colors_skin.pick_random()
	for i in _clothe_skin:
		i.color = color_skin


func _check_if_should_be_destroyed():
	if global_position.x > 1300 or global_position.x < -500:
		print("Paseant.free()")
		queue_free()
	
