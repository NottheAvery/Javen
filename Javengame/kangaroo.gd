extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -200.0
var spawn_position: Vector2

func _ready() -> void:
	spawn_position = global_position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	if velocity.x > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true
	if is_on_floor():
		anim.frame = 1
	else:
		anim.frame = 0
	
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		
		if collider is TileMapLayer:
			var tilemap: TileMapLayer = collider
			var hit_pos: Vector2 = collision.get_position() - collision.get_normal() * 2.0
			var local_pos: Vector2 = tilemap.to_local(hit_pos)
			var tile_coords: Vector2i = tilemap.local_to_map(local_pos)
			
			var source_id: int = tilemap.get_cell_source_id(tile_coords)
			if source_id == 1:
				respawn()
				break
			if source_id == 0:
				velocity.y = -400

func respawn() -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO  # Reset momentum so you don't keep falling/sliding
