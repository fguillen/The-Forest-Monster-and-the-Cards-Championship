extends CanvasLayer

@export var card_combat_scene: PackedScene

@onready var card_placeholder_monster: Node2D = $CardPlaceholderMonster
@onready var card_placeholder_oponent: Node2D = $CardPlaceholderOponent
@onready var deck_container_monster: Container = %DeckMonster
@onready var deck_container_oponent: Container = %DeckOponent

var card_values_monster: Array[CardValue] = []
var card_values_oponent: Array[CardValue] = []
var cards_monster: Array[CardCombat] = []
var cards_oponent: Array[CardCombat] = []


func select_card(card_combat: CardCombat, card_placeholder: Node2D):
	card_combat.reparent_and_jump(card_placeholder)


# Called when the node enters the scene tree for the first time.
func _ready():
	var card_value = CardValue.new()
	for i in 4:
		card_values_monster.append(card_value)
		card_values_oponent.append(card_value)
		
	_set_up_decks()


func _set_up_decks():
	for card_value in card_values_monster:
		var card_combat := card_combat_scene.instantiate() as CardCombat
		card_combat.setup(card_value)
		cards_monster.append(card_combat)
		deck_container_monster.add_child(card_combat)
		card_combat.selected.connect(select_card.bind(card_placeholder_monster))
		
	for card_value in card_values_oponent:
		var card_combat := card_combat_scene.instantiate() as CardCombat
		card_combat.setup(card_value)
		cards_oponent.append(card_combat)
		deck_container_oponent.add_child(card_combat)
		card_combat.selected.connect(select_card.bind(card_placeholder_oponent))
