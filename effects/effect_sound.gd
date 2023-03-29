extends AudioStreamPlayer

@export var random_pitch := false
@export var start_at_random_seek := false
@export var samples: Array[AudioStream]


func perform():
	if not samples.is_empty():
		stream = _random_sample()
		
	if random_pitch:
		pitch_scale = randf_range(0.8, 1.2)
	
	var starting_seek = 0.0 if not start_at_random_seek else _random_seek()
	play(starting_seek)


func finish():
	stop()


func _random_seek():
	return randf_range(0.0, stream.get_length())

	
func _random_sample() -> AudioStream:
	return samples.pick_random()
