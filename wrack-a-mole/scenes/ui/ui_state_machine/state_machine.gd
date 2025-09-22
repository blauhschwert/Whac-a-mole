class_name UIStateMachine
extends Control

@onready var _label = $Label
var base_text = "State : "
var _state_name : String = ""


func _ready():
	_label = Label.new()
	add_child(_label)
	_label.text = base_text + _state_name

func _init(p_name : String = "base") -> void:
	_state_name = p_name

func change_state_name(p_name : String) -> void:
	_state_name = p_name
