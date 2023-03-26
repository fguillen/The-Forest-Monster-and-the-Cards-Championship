class_name Card
extends RigidBody2D

@export var jump_force := 100.0
var code = "Card01"


func jump():
	call_deferred("_jump_deferred")
	

func pick():
	call_deferred("_pick_deferred")
	

func _pick_deferred():
	Global.pick_card(self)
	queue_free()
	
	
func _jump_deferred():
	print("Card.jump()")
	var actual_position = global_position
	var current_scene = get_tree().get_current_scene()
	
	get_parent().remove_child(self)
	current_scene.add_child(self)
	global_position = actual_position
	
	freeze = false
	apply_impulse(Vector2.UP * jump_force)
	
	
