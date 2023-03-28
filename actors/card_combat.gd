class_name CardCombat
extends Control

signal selected(card_combat: CardCombat)

@onready var click_area: Area2D = $ClickArea2D
@onready var card_front: CardFront = %CardFront
@onready var back: Sprite2D = %Back
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var value: CardValue


func setup(card_value: CardValue):
	value = card_value
	card_front.setup(card_value)
	
	
func reparent_and_jump(new_parent: Node2D):
	print("CardCombat.reparent_and_jump")
	
	# Deactivate Click
	click_area.monitoring = false
	
	# Reparent
	var actual_position = global_position
	get_parent().remove_child(self)
	new_parent.add_child(self)
	global_position = actual_position
	
	# Jump
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", new_parent.global_position, 0.5)
	await tween.finished
	

func show_front():
	back.visible = false
	card_front.visible = true	
	

func show_back():
	back.visible = true
	card_front.visible = false
	
	
func flip_front():
	animation_player.play("flip_front")
	await animation_player.animation_finished


func _select():
	emit_signal("selected", self)


func _on_click_area_2d_input_event(viewport, event, shape_idx):
	print("CardCombat._on_click_area_2d_input_event()")
	
	if Input.is_action_just_pressed("click"):
		_select()


func _on_gui_input(event):
	print("CardCombat._on_gui_input()")
	print("CardCombat._on_gui_input(): ", event.get_class())
	if event is InputEventMouseButton:
		print("CardCombat._on_gui_input(): ", event.button_index)
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_select()
		
	
