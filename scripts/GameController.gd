extends Node

@onready var fall_timer = %FallTimer
@onready var move_timer = %MoveTimer

var level = 1
# var rng = RandomNumberGenerator.new()

func level_up():
	fall_timer.wait_time /= 2
	level += 1
