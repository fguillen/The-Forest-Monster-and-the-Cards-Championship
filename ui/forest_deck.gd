class_name ForestDeck
extends CanvasLayer

signal no_free_placeholder_found()

@onready var placeholders_node: Node = %Placeholders

var placeholders: Array[ForestDeckPlaceholder] = []

func _ready():
	_setup_placeholders()
	Global.card_picked.connect(_on_card_picked)


func add_card(card_value: CardValue, from_position: Vector2):
	var placeholder = _get_first_free_placeholder()
	
	if not placeholder:
		emit_signal("no_free_placeholder_found")
	else:
		_get_first_free_placeholder().put_card_front(card_value, from_position)
	

func _get_first_free_placeholder() -> ForestDeckPlaceholder:
	for placeholder in placeholders:
		if placeholder.card_value == null:
			return placeholder
			
	push_error("ForestDeck no available Placeholders")
	return null
	
	
func _setup_placeholders():
	for child in placeholders_node.get_children():
		placeholders.append(child)


func _on_card_picked(card_value: CardValue, from_position: Vector2):
	print("ForestDeck._on_card_picked()")
	add_card(card_value, from_position)
