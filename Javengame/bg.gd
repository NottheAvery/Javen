extends Sprite2D
@export var player: CharacterBody2D

@export var fixed_y: float = 201.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player:
		global_position.x = player.global_position.x
		global_position.y = fixed_y
