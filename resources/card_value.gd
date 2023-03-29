class_name CardValue
extends Resource

var initiative := 0
var attack := 0
var defense := 0


static func random_new():
	var random_card_value = CardValue.new()
	random_card_value.attack = randi_range(0, 9)
	random_card_value.defense = randi_range(0, 9)
	
	return random_card_value

