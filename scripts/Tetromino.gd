extends CharacterBody2D

const STEP = 64

signal bottom_hit
var can_move = false

func _ready():
	can_move = false
	
func activate():
	can_move = true

func _process(_delta):
	if can_move:
		print(self.position)
		if Input.is_action_just_pressed("drop"):
			fall(20)
		if Input.is_action_just_pressed("rotate_clockwise"):
			rotation += PI/2
			if move_and_collide(Vector2(0,0)):
				#rotate(-PI/2)
				rotation -= PI/2
				
		if Input.is_action_just_pressed("rotate_counter_clockwise"):
			rotate(-PI/2)
			if move_and_collide(Vector2(0,0)):
				rotate(PI/2)
				
		if fmod(self.position.x, STEP) != 0:
			self.position.x = round_to_multiple_of_STEP(self.position.x)
		if fmod(self.position.y, STEP) != 0:
			self.position.y = round_to_multiple_of_STEP(self.position.y)

func round_to_multiple_of_STEP(number: float) -> int:
	return int(int(number + 32)/ STEP) * STEP

func fall(nb_steps):
	var result = move_and_collide(Vector2(0,nb_steps * STEP))
	if result:
		can_move = false
		emit_signal("bottom_hit")

func on_fall_timer_timeout():
	if can_move:
		fall(1)
	
func on_move_timer_timeout():
	if not can_move:
		pass
	if Input.is_action_pressed("move_left"):
		move_and_collide(Vector2(-1 * STEP, 0))
	if Input.is_action_pressed("move_right"):
		move_and_collide(Vector2(STEP, 0))
	if Input.is_action_pressed("move_down"):
		fall(1)
