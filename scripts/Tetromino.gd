extends AnimatableBody2D

const STEP = 64.0

signal bottom_hit
var can_move = false

func _ready():
	can_move = true

func _process(_delta):
	if can_move and Input.is_action_just_pressed("drop"):
		fall(20)

func fall(nb_steps):
	var result = move_and_collide(Vector2(0,nb_steps * STEP))
	if result:
		can_move = false
		emit_signal("bottom_hit")
		
func move(to_right):
	move_and_collide(Vector2(STEP if to_right else -1 * STEP, 0))

func on_fall_timer_timeout():
	if can_move:
		fall(1)
	
func on_move_timer_timeout():
	if not can_move:
		pass
	elif Input.is_action_pressed("move_left"):
		move(false)
	elif Input.is_action_pressed("move_right"):
		move(true)
