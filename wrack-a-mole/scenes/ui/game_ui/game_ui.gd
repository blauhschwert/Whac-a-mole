class_name GameUI
extends Control

var score : int = 0
@onready var _score_label = $ScoreLabel

func _ready():
	_score_label.text = "Score : " + str(score)

func _process(_delta):
	_score_label.text = "Score : " + str(score)

func add_points(p_points : int) -> int:
	return score + p_points

func _on_holes_mole_wracked(points):
	score = add_points(points)
