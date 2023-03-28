extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.deck_filled.connect(_on_deck_filled)
	Global.reset()


func _on_deck_filled():
	print("Forest._on_deck_filled()")
	get_tree().change_scene_to_file("res://scenes/combat.tscn")
