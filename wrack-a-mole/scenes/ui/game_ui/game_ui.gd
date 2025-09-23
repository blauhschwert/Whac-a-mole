class_name GameUI
extends Control

var score : int = 0
@onready var _score_label = $ScoreLabel

func _ready():
	_score_label.text = "Score : " + str(Globals.score)

func _process(_delta):
	_score_label.text = "Score : " + str(Globals.score)
