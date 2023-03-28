class_name MonsterEye
extends Node2D

@onready var paseants_sensor: Area2D = $PaseantsSensor
@onready var pupil: Node2D = $Pupil
@onready var eye_limit_left: Node2D = $EyeLimitLeft
@onready var eye_limit_right: Node2D = $EyeLimitRight
@onready var paseant_limit_left: Node2D = $PaseantLimitLeft
@onready var paseant_limit_right: Node2D = $PaseantLimitRight


var paseant_limit_length: float

func _ready():
	paseant_limit_length = paseant_limit_left.global_position.distance_to(paseant_limit_right.global_position)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var paseants = paseants_sensor.get_overlapping_bodies() as Array[Node2D]
	if not paseants.is_empty():
		var closest_paseant = _closest_node(paseants)
		var distance_to_paseant_limit_left = paseant_limit_left.global_position.distance_to(closest_paseant.global_position)
		pupil.global_position = eye_limit_left.global_position.lerp(eye_limit_right.global_position, (distance_to_paseant_limit_left / paseant_limit_length))

		
func _closest_node(nodes: Array[Node2D]) -> Node2D:
	nodes.sort_custom(func(node):
		return global_position.distance_squared_to(node.global_position)
	)
	return nodes[0]
		
