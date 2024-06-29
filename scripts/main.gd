extends Node2D

@onready var tetromino_factory = $TetrominoFactory
var current_tetromino

const STEP = 64
const START_X = 5*STEP
const START_Y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_setup_tetromino()

func _on_current_tetromino_bottom_hit():
	_setup_tetromino()
	
func _setup_tetromino():
	var new_tetromino = tetromino_factory.create()
	new_tetromino.position.x = START_X
	new_tetromino.position.y = START_Y
	current_tetromino = new_tetromino
	add_child(current_tetromino)
	current_tetromino.connect("bottom_hit", _on_current_tetromino_bottom_hit)

func _on_fall_timer_timeout():
	if current_tetromino != null:
		current_tetromino.on_fall_timer_timeout()

func _on_move_timer_timeout():
	if current_tetromino != null:
		current_tetromino.on_move_timer_timeout()
