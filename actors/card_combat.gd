class_name CardCombat
extends Control

signal selected(card_combat: CardCombat)

@onready var click_area: Area2D = $ClickArea2D

var value: CardValue


func setup(card_value: CardValue):
	self.value = card_value
	
	
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
	tween.tween_property(self, "global_position", new_parent.global_position, 1.0)
	

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
