class_name Mole
extends Node2D

signal finishMole

enum State {RESET, POPPING_UP, IDLE, HIT, HIDE}
var state  : State = State.RESET

@export var is_active : bool = false:
	set(value):
		is_active = value
	get:
		return is_active

@onready var anim_player = $AnimationPlayer

func _ready():
	randomize()
	$MoleTimer.paused = true
	$AttackNode.visible = false
	anim_player.animation_finished.connect(_on_animation_finished)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		print("Touched : ", name, " | Finger ID: ", event.index)
		modulate = Color(1,0,0) # Change color to indicate touch
		await get_tree().create_timer(0.3).timeout
		modulate = Color(1,1,1) # Change color to indicate touch
		set_state(State.HIT)
		
	elif event is InputEventMouseButton and event.is_pressed():
		modulate = Color(1,0,0) # Change color to indicate touch
		await get_tree().create_timer(0.3).timeout
		modulate = Color(1,1,1) # Change color to indicate touch
		set_state(State.HIT)

func set_state(new_state : State) -> void:
	if state == new_state:
		return
	state = new_state

	match state:
		State.RESET:
			anim_player.play("RESET")
		State.POPPING_UP:
			anim_player.play("pop_up")
		State.IDLE:
			anim_player.play("idle")
		State.HIT:
			Globals.emit_signal("toggle_player",false)
			$AttackNode.visible = true
			$HitSound.play()
			anim_player.play("hit")
		State.HIDE:
			anim_player.play("dissapear")
			await get_tree().create_timer(0.3).timeout
			Globals.emit_signal("toggle_player",true)

func _on_animation_finished(_anim_name : String) -> void:
	match _anim_name:
		"pop_up":
			set_state(State.IDLE)
		"hit":
			finishMole.emit()
			set_state(State.HIDE)
		"dissapear":
			$MoleTimer.wait_time = randf_range(2.0,3.1)
			$MoleTimer.start()
			queue_free()
			Globals.add_score(Globals.rand_score())
		

func mole_autostart() -> void:
	anim_player.play("pop_up")
	print("appear")
	is_active = true


func _on_timer_timeout():
	anim_player.play("dissapear")
	finishMole.emit()
