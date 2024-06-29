extends Node2D

@onready var tetromino_factory = $TetrominoFactory
@onready var level_text = %LevelText
@onready var score_text = %ScoreText
@onready var next_container = %NextContainer
@onready var hold_control = %HoldControl
@onready var next_0 = %Next0
@onready var next_1 = %Next1
@onready var next_2 = %Next2


var current_tetromino
var hold
var next = []
var level = 1
var score = 0

const STEP = 64
const START_X = 5*STEP
const START_Y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	next = [next_0, next_1, next_2]
	init_next()
	_setup_tetromino()
	update_score()
	update_level()

func update_score():
	score_text.text = str(score)

func update_level():
	level_text.text = str(level)
	
func init_next():
	for i in range(3):
		var tetromino = tetromino_factory.create()
		next[i].add_child(tetromino)
		
func pop_next():
	var in_child = tetromino_factory.create()
	var out_child
	for i in range(3):
		if i == 0:
			out_child = move_next_child(i)
		else:
			move_next_child(i)
	next[2].add_child(in_child)
	
	return out_child

func move_next_child(index):
	print(next[index].get_children())
	var child = next[index].get_children()[0]
	next[index].remove_child(child)
	
	if index != 0:
		next[index - 1].add_child(child)
	
	return child

func _on_current_tetromino_bottom_hit():
	_setup_tetromino()
	
func _setup_tetromino():
	var new_tetromino = pop_next()
	new_tetromino.position.x = START_X
	new_tetromino.position.y = START_Y
	current_tetromino = new_tetromino
	add_child(current_tetromino)
	current_tetromino.connect("bottom_hit", _on_current_tetromino_bottom_hit)
	current_tetromino.activate()

func _on_fall_timer_timeout():
	if current_tetromino != null:
		current_tetromino.on_fall_timer_timeout()

func _on_move_timer_timeout():
	if current_tetromino != null:
		current_tetromino.on_move_timer_timeout()
