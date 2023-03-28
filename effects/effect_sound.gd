extends AudioStreamPlayer

@export var start_at_random_seek := false


func perform():
	var seek = 0.0 if not start_at_random_seek else _random_seek()
	play(seek)


func finish():
	stop()


func _random_seek():
	return randf_range(0.0, stream.get_length())
