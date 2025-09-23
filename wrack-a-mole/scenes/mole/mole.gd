class_name Mole
extends Node2D

signal finishMole

enum State {RESET, POPPING_UP, IDLE, HIT}
var state  : State = State.RESET

@export var is_active : bool = false:
	set(value):
		is_active = value
	get:
		return is_active

@onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.animation_finished.connect(_on_animation_finished)
	@warning_ignore("narrowing_conversion")
	#$MoleTimer.wait_time = randi_range(2.0,4.5)
	$MoleTimer.paused = true

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		print("Touched : ", name, " | Finger ID: ", event.index)
		modulate = Color(1,0,0) # Change color to indicate touch
		mole_state_hidden()
		finishMole.emit()
	elif event is InputEventMouseButton and event.is_pressed():
		modulate = Color(1,0,0) # Change color to indicate touch
		mole_state_hidden()		
		finishMole.emit()


func _on_animation_finished(_anim_name : String) -> void:
	if _anim_name == "hidden":
		queue_free()
	

func mole_autostart() -> void:
	anim_player.play("pop_up")
	is_active = true

func mole_state_hidden()  -> void:
	$HitSound.play()
	anim_player.play("hidden")
	

func _on_timer_timeout():
	mole_state_hidden()
