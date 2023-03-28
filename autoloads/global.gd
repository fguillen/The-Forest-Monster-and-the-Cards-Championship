extends Node

signal card_picked(card_value: CardValue, position: Vector2)
signal deck_filled()

var picked_cards: Array[CardValue] = []
var was_a_win := false


func pick_card(card_value: CardValue, position: Vector2):
	print("Global.pick_card: ", card_value)
	picked_cards.append(card_value)
	emit_signal("card_picked", card_value, position)
	
	print("picked_cards.size(): ", picked_cards.size())
	
	if picked_cards.size() == 4:
		emit_signal("deck_filled")

func reset():
	picked_cards = []
	was_a_win = false

func _random_monster_cards():
	for i in 4:
		var random_card_value = CardValue.new()
		random_card_value.attack = randi_range(0, 9)
		random_card_value.defense = randi_range(0, 9)
		picked_cards.append(random_card_value)
