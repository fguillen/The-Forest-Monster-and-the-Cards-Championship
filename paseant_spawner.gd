class_name PaseantSpawner
extends Node2D

@export var paseant_scene: PackedScene

@export_range(0.1, 20.0) var spawn_first_time := 10
@export_range(0.1, 20.0) var spawn_interval_min := 0.5
@export_range(0.1, 20.0) var spawn_interval_max := 3.0

@onready var _timer: Timer = $Timer


func _ready():
	_timer.start(spawn_first_time)


func spawn():
	var paseant = paseant_scene.instantiate()
	add_child(paseant)
	_next_interval()
	

func _on_timer_timeout():
	spawn()
	
	
func _next_interval():
	_timer.start(randf_range(spawn_interval_min, spawn_interval_max))
