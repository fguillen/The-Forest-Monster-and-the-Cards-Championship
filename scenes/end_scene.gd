extends CanvasLayer


@onready var text_label: Label =  $MarginContainer/VBoxContainer/TextLabel


func _ready():
	if Global.was_a_win:
		text_label.text = "You won!"
	else:
		text_label.text = "You missed!"



func _on_try_again_button_pressed():
	get_tree().change_scene_to_file("res://testing/forest.tscn")
