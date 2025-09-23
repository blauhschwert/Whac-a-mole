class_name Global
extends Node

signal score_changed(new_score : int)

@warning_ignore("unused_signal")
signal toggle_player(bool)

var score : int = 0
var mole_points = [10,15,35]

func add_score(points : int) -> void:
	score = points
	emit_signal("score_changed",score)

func rand_score() -> int:
	return mole_points[randi() % mole_points.size()]
