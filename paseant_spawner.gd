class_name PaseantSpawner
extends Node2D

@export var paseant_scene: PackedScene
@export_range(0.1, 10.0) var spawn_interval_min := 0.5
@export_range(0.1, 10.0) var spawn_interval_max := 3

@onready var _timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	_next_interval()


func spawn():
	var paseant = paseant_scene.instantiate()
	add_child(paseant)
	_next_interval()
	

func _on_timer_timeout():
	spawn()
	
	
func _next_interval():
	_timer.start(randf_range(spawn_interval_min, spawn_interval_max))
