class_name Hole
extends Area2D

# use time to create midpoint for extra score
# signal wrackedMole(Time)
signal finishMole
signal moleClear
signal moleCreated

const MOLE = preload("res://scenes/mole/mole.tscn")

@onready var _mole : Mole = null

func _ready() -> void:
	create_mole()
	show_mole()
	
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		print("Touched : ", name, " | Finger ID: ", event.index)
		modulate = Color(1,0,0) # Change color to indicate touch
		hide_mole()
		finishMole.emit()

func create_mole() -> void:
	_mole = MOLE.instantiate()
	add_child(_mole)

func show_mole() -> void:
	if _mole != null:
		_mole.mole_autostart()

func hide_mole() -> void:
	if _mole != null:
		_mole.mole_state_hidden()

func is_moles_active() -> bool:
	return _mole.is_active

func _reset_hole_status() -> void:
	await get_tree().create_timer(0.4).timeout
	modulate = Color(1,1,1) # Change color to indicate touch
	moleClear.emit()
