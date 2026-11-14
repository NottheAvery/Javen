extends AudioStreamPlayer2D
@export var camera = Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = camera.global_position
