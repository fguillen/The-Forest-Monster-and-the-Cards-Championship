extends Node

var picked_cards: Array[CardValue] = []


func _ready():
	_random_monster_cards()


func pick_card(card_value: CardValue):
	print("Global.pick_card: ", card_value)
	picked_cards.append(card_value)


func _random_monster_cards():
	for i in 4:
		var random_card_value = CardValue.new()
		random_card_value.attack = randi_range(0, 9)
		random_card_value.defense = randi_range(0, 9)
		picked_cards.append(random_card_value)
