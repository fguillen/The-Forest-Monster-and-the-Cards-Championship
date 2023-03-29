extends CanvasLayer

signal card_selected_but_no_possible()
signal card_selected()
signal monster_won()
signal monster_lost()
signal attack_success()
signal attack_fail()

@export var card_combat_scene: PackedScene
@export var debug_monster_cards := false

@onready var card_placeholder_monster: Node2D = $CardPlaceholderMonster
@onready var card_placeholder_oponent: Node2D = $CardPlaceholderOponent
@onready var deck_container_monster: Container = %DeckMonster
@onready var deck_container_oponent: Container = %DeckOponent
@onready var points_monster_label: Label = $PointsMonsterLabel
@onready var points_oponent_label: Label = $PointsOponentLabel

var card_values_monster: Array[CardValue] = []
var card_values_oponent: Array[CardValue] = []
var cards_monster: Array[CardCombat] = []
var cards_oponent: Array[CardCombat] = []
var points_monster := 0 : set = _set_points_monster
var points_oponent := 0 : set = _set_points_oponent

var oponent_card_in_placeholder: CardCombat
var monster_card_in_placeholder: CardCombat


func select_card(card_combat: CardCombat, card_placeholder: Node2D):
	if card_placeholder == card_placeholder_monster and monster_card_in_placeholder:
		print("Card already selected")
		emit_signal("card_selected_but_no_possible")
		return
		
	if card_placeholder == card_placeholder_oponent and oponent_card_in_placeholder:
		print("Card already selected")
		emit_signal("card_selected_but_no_possible")
		return
	
	emit_signal("card_selected")
	
	if card_placeholder == card_placeholder_monster:
		monster_card_in_placeholder = card_combat
	else: 
		oponent_card_in_placeholder = card_combat
		
	await card_combat.reparent_and_jump(card_placeholder)
		
	if monster_card_in_placeholder and oponent_card_in_placeholder:
		_combat(monster_card_in_placeholder, oponent_card_in_placeholder)
		
	if card_placeholder == card_placeholder_monster:
		_oponent_select_random_card()


func _ready():
	Global.was_a_win = false
	
	if debug_monster_cards:
		for i in 4:
			var random_card_value = CardValue.random_new()
			card_values_monster.append(random_card_value)
	else:
		for card_value in Global.picked_cards:
			card_values_monster.append(card_value)
	
	for i in 4:
		var random_card_value = CardValue.random_new()
		card_values_oponent.append(random_card_value)
		
	_set_up_decks()


func _set_up_decks():
	for card_value in card_values_monster:
		var card_combat := card_combat_scene.instantiate() as CardCombat
		cards_monster.append(card_combat)
		deck_container_monster.add_child(card_combat)
		card_combat.setup(card_value)
		card_combat.show_front()
		card_combat.selected.connect(select_card.bind(card_placeholder_monster))
		
	for card_value in card_values_oponent:
		var card_combat := card_combat_scene.instantiate() as CardCombat
		cards_oponent.append(card_combat)
		deck_container_oponent.add_child(card_combat)
		card_combat.setup(card_value)
		card_combat.show_back()
#		card_combat.selected.connect(select_card.bind(card_placeholder_oponent))


func _combat(card_combat_monster: CardCombat, card_combat_oponent: CardCombat):
	await card_combat_oponent.flip_front()
	
	# Order
	if card_combat_monster.value.initiative >= card_combat_oponent.value.initiative:
		# Monster attack
		var original_position = card_combat_monster.global_position
		var result = await _attack(card_combat_monster, card_combat_oponent)
		if result: 
			points_monster += 1
		await _return_position(card_combat_monster, original_position)
		
		# Oponent attack
		original_position = card_combat_oponent.global_position
		result = await _attack(card_combat_oponent, card_combat_monster)
		if result: 
			points_oponent += 1
		await _return_position(card_combat_oponent, original_position)
		
		# Clean
		monster_card_in_placeholder = null
		oponent_card_in_placeholder = null
		cards_monster.erase(card_combat_monster)
		cards_oponent.erase(card_combat_oponent)
		card_combat_monster.queue_free()
		card_combat_oponent.queue_free()
		
		# End?
		if cards_monster.is_empty():
			var was_a_win = points_monster >= points_oponent
			if was_a_win:
				emit_signal("monster_won")
			else:
				emit_signal("monster_lost")
			Global.was_a_win = was_a_win
			await get_tree().create_timer(3.0).timeout
			get_tree().change_scene_to_file("res://scenes/end_scene.tscn")
		
		
		
func _attack(card_combat_attack: CardCombat, card_combat_deffend: CardCombat):
	var tween = get_tree().create_tween()
	tween.tween_property(card_combat_attack, "global_position", card_combat_deffend.global_position, 0.5)
	await tween.finished
	if card_combat_attack.value.attack >= card_combat_deffend.value.defense:
		emit_signal("attack_success")
		return true
	else:
		emit_signal("attack_fail")
		return false
		

func _return_position(card_combat_attack: CardCombat, position: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(card_combat_attack, "global_position", position, 0.5)
	await tween.finished


func _set_points_monster(value: int):
	points_monster = value
	points_monster_label.text = str(points_monster)
	
	
func _set_points_oponent(value: int):
	points_oponent = value
	points_oponent_label.text = str(points_oponent)
	

func _oponent_select_random_card():
	var random_card = cards_oponent.pick_random()
	select_card(random_card, card_placeholder_oponent)

