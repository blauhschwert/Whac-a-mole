class_name Hole
extends Node2D

# use time to create midpoint for extra score
# signal wrackedMole(Time)
signal moleClear
signal moleCreated

const MOLE = preload("res://scenes/mole/mole.tscn")

@onready var _mole : Mole = null

func _ready() -> void:
	show_mole()

func create_mole() -> void:
	_mole = MOLE.instantiate()
	add_child(_mole)
	moleCreated.emit()

func show_mole() -> void:
	if _mole != null:
		_mole.mole_autostart()

func is_moles_active() -> bool:
	return _mole.is_active

func _reset_hole_status() -> void:
	await get_tree().create_timer(0.4).timeout
	modulate = Color(1,1,1) # Change color to indicate touch
	moleClear.emit()
