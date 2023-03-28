class_name CardFront
extends Node2D

@onready var attack_label: Label = $AttackLabel
@onready var defense_label: Label = $DefenseLabel


func setup(card_value: CardValue):
	attack_label.text = str(card_value.attack)
	defense_label.text = str(card_value.defense)
	
