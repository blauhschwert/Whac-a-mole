class_name Game
extends Node2D

@onready var _player = %Player

func _ready() -> void:
	Globals.toggle_player.connect(_toggle_player)

func _toggle_player(p_vis : bool) -> void:
	_player.visible = p_vis
