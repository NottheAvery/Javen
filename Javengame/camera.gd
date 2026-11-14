extends Camera2D
@onready var timer: Timer = $Timer
@onready var timer2: Timer = $Timer2
@onready var target_marker: Marker2D = $Marker2D
@export var player: CharacterBody2D

@export var fixed_y: float = 201.0
@export var min_x: float = -2000.0
@export var max_x: float = 0.0

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer2.timeout.connect(follow_player_bounded)

func _on_timer_timeout() -> void:
	global_position = target_marker.global_position

func _process(_delta: float) -> void:
	if timer2.time_left < 1:
		follow_player_bounded()
		zoom = Vector2(6, 6)

func follow_player_bounded() -> void:
	if player:
		global_position.x = clamp(player.global_position.x, min_x, max_x)
		global_position.y = fixed_y
