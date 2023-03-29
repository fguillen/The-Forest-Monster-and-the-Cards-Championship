extends Node2D

@onready var animation_player:AnimationPlayer = $AnimationPlayer

func attack_win():
	animation_player.play("attack_success")
	
func win():
	animation_player.play("win")
	
func lose():
	animation_player.play("lose")

