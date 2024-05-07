extends Node

@onready var fall_timer = %FallTimer

var level = 1

func level_up():
	fall_timer.wait_time /= 2
	level += 1

