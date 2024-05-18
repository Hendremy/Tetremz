extends Node

var rng = RandomNumberGenerator.new()
var t_tetromino = preload("res://scenes/t_tetromino.tscn")
var line_tetromino = preload("res://scenes/line_tetromino.tscn")
var z_tetromino = preload("res://scenes/z_tetromino.tscn")
var s_tetromino = preload("res://scenes/s_tetromino.tscn")
var cube_tetromino = preload("res://scenes/cube_tetromino.tscn")
var l_tetromino = preload("res://scenes/l_tetromino.tscn")
var reverse_l_tetromino = preload("res://scenes/reverse_l_tetromino.tscn")

func create():
	var next = rng.randi_range(0,6)
	return _instantiate_tetromino(next)

func _instantiate_tetromino(number):
	var tetromino
	match number:
		0 :
			tetromino = cube_tetromino.instantiate()
		1 :
			tetromino = s_tetromino.instantiate()
		2:
			tetromino = z_tetromino.instantiate()
		3:
			tetromino = t_tetromino.instantiate()
		4:
			tetromino = l_tetromino.instantiate()
		5:
			tetromino = reverse_l_tetromino.instantiate()
		6:
			tetromino = line_tetromino.instantiate()
	return tetromino
