extends Node2D

@onready var tetromino_factory = $TetrominoFactory
@onready var level_text = %LevelText
@onready var lines_text = %LinesText
@onready var score_text = %ScoreText
@onready var next_container = %NextContainer
@onready var hold_control = %HoldControl
@onready var next_0 = %Next0
@onready var next_1 = %Next1
@onready var next_2 = %Next2
@onready var next = []
@onready var lines = 0
@onready var level = 1
@onready var score = 0
@onready var hold_available = true

var current_tetromino
var hold

const STEP = 64
const START_X = 5*STEP
const START_Y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	next = [next_0, next_1, next_2]
	init_next()
	update_score()
	update_level()
	update_lines()
	_setup_tetromino(pop_next())

func update_score():
	score_text.text = str(score)

func update_level():
	level_text.text = str(level)
	
func update_lines():
	lines_text.text = str(lines)
	
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
	
func swap_hold():
	var out_tetromino
	if hold_control.get_child_count() > 0:
		out_tetromino = hold_control.get_children()[0]
		hold_control.remove_child(out_tetromino)
	else:
		out_tetromino = pop_next()
	
	current_tetromino.activate(false)
	current_tetromino.reparent(hold_control)
	current_tetromino.disconnect('bottom_hit',_on_current_tetromino_bottom_hit)
	current_tetromino.disconnect('hold_pressed',_on_current_tetromino_hold_pressed)
	current_tetromino.position.x = 0
	current_tetromino.position.y = 0
	
	hold_available = false
	
	return out_tetromino

func _on_current_tetromino_bottom_hit():
	_setup_tetromino(pop_next())
	hold_available = true
	
func _on_current_tetromino_hold_pressed():
	if hold_available:
		_setup_tetromino(swap_hold())
	
func _setup_tetromino(tetromino):
	tetromino.position.x = START_X
	tetromino.position.y = START_Y
	current_tetromino = tetromino
	add_child(current_tetromino)
	current_tetromino.connect("bottom_hit", _on_current_tetromino_bottom_hit)
	current_tetromino.connect("hold_pressed", _on_current_tetromino_hold_pressed)
	current_tetromino.activate(true)

func _on_fall_timer_timeout():
	if current_tetromino != null:
		current_tetromino.on_fall_timer_timeout()

func _on_move_timer_timeout():
	if current_tetromino != null:
		current_tetromino.on_move_timer_timeout()
