extends Camera2D
@onready var timer: Timer = $Timer
@onready var timer2: Timer = $Timer2
@onready var target_marker: Marker2D = $Marker2D
@export var player: CharacterBody2D

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer2.timeout.connect(_on_timer_timeout_2)
func _on_timer_timeout() -> void:
	global_position = target_marker.global_position
func _on_timer_timeout_2():
	global_position = player.global_position
