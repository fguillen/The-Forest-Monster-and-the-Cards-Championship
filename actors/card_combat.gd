class_name CardCombat
extends Control

signal selected(card_combat: CardCombat)

var value: CardValue


func setup(card_value: CardValue):
	self.value = card_value


func _select():
	emit_signal("selected", self)


func _on_click_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		_select()
