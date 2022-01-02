extends Node2D

export(int) var wander_range = 32

onready var start = global_position
onready var target = global_position

func _ready():
	update_target_position()

func update_target_position():
	var offset = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target = start + offset

func get_time_left():
	return $Timer.time_left

func start_timer(duration):
	$Timer.start(duration)

func _on_Timer_timeout():
	update_target_position()
