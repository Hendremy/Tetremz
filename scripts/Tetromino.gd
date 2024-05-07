extends CharacterBody2D

const STEP = 64.0

@onready var fall_timer = %FallTimer

func _physics_process(delta):
	if Input.is_action_just_pressed("slam"):
		move_and_collide(Vector2(0,20*STEP))

func _on_fall_timer_timeout():
	move_and_collide(Vector2(0,STEP))
	
func _on_move_timer_timeout():
	if Input.is_action_pressed("move_left"):
		move_and_collide(Vector2(-1 * STEP,0))
	elif Input.is_action_pressed("move_right"):
		move_and_collide(Vector2(STEP,0))
