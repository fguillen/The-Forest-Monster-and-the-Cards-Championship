extends Node

var cards = []

func pick_card(card: Card):
	print("Global.pick_card: ", card.code)
	cards.append(card)


