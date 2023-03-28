class_name Monster
extends CharacterBody2D

signal pick_not_possible()
signal card_picked()
signal in_hidden()
signal in_unhidden()
signal walk_started()
signal idle_started()
signal scare_started()

@export var max_speed := 100.0
@export var acceleration := 50.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: CanvasItem = $Visuals
@onready var visuals_hidden: CanvasItem = $VisualsHidden


var _state := "idle"
var _hidden := true
var _direction := 0.0
var _deck_filled := false

func _ready():
	_set_state_idle()
	_set_state_hidden()
	
	Global.deck_filled.connect(_on_deck_filled)
	

func _physics_process(delta):
	# Move if not scaring
	if not _state == "scare":
		_direction = Input.get_axis("ui_left", "ui_right")
		var max_velocity = Vector2(_direction * max_speed, 0)
		velocity = velocity.lerp(max_velocity, acceleration * delta)
		move_and_slide()
		if _direction:
			_set_state_walk()
#			_flip_towards_direction()
		else:
			_set_state_idle()
	
	# Hide
	if Input.is_action_just_pressed("ui_up"):
		_set_state_hidden()
		
	# Unhide
	if Input.is_action_just_pressed("ui_down"):
		_set_state_unhidden()
		
	# Scare
	if not _hidden:
		if Input.is_action_just_pressed("ui_accept"):
			_set_state_scare()
		

func _set_state_hidden():
	_hidden = true
	visuals.visible = false
	visuals_hidden.visible = true
	emit_signal("in_hidden")
	
	
func _set_state_unhidden():
	_hidden = false
	visuals.visible = true
	visuals_hidden.visible = false
	emit_signal("in_unhidden")


func _set_state_idle():
	_state = "idle"
	if _hidden:
		animation_player.play("idle_hidden")
	else: 
		animation_player.play("idle")
		
	emit_signal("idle_started")
	
	
func _set_state_walk():
	_state = "walk"
	if _hidden:
		animation_player.play("walk_hidden")
	else: 
		animation_player.play("walk")
		
	emit_signal("walk_started")


func _set_state_scare():
	_state = "scare"
	animation_player.play("scare")
	emit_signal("scare_started")


func _on_animation_player_animation_finished(anim_name):
	if _state == "scare":
		_set_state_idle()


func _on_scare_area_2d_body_entered(body):
	if body is Paseant:
		body.scare()


func _on_pick_area_2d_body_entered(body):
	if body is Card:
		if _deck_filled:
			emit_signal("pick_not_possible")
		else: 
			emit_signal("card_picked")
			body.pick()


func _flip_towards_direction():
	var direction_sign = sign(_direction)
	print("direction_sign: ", direction_sign)
	if not direction_sign == 0 and not scale.x == direction_sign:
		scale = Vector2(direction_sign, 1)


func _on_deck_filled():
	_deck_filled = true
