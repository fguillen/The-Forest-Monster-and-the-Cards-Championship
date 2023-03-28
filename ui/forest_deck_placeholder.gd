class_name ForestDeckPlaceholder
extends Container

@export var card_front_scene: PackedScene

var card_value: CardValue

func put_card_front(card_value: CardValue, from_position: Vector2):
	print("ForestDeckPlaceholder.put_card_front()")
	
	self.card_value = card_value
	var card_front = card_front_scene.instantiate()
	add_child(card_front)
	card_front.setup(card_value)
	card_front.global_position = from_position
	
	_jump_to_place_holder(card_front)
	
	
func _jump_to_place_holder(card_front: CardFront):
	var tween = get_tree().create_tween()
	tween.tween_property(card_front, "global_position", global_position, 0.2)
	await tween.finished
	
