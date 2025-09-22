class_name Holes
extends Node

# All the holes that got a mole
@onready var hole_00 = $Hole_00
@onready var hole_01 = $Hole_01
@onready var hole_02 = $Hole_02
@onready var hole_03 = $Hole_03

var holes_dict = {
	"hole_00" : [],
	"hole_01" : [],
	"hole_02" : [],
	"hole_03" : []
}

var holes = []
var hole_patterns = [] # Mole Pattern for game
var active_moles : int = 0


func _ready() -> void:
	randomize()
	for i in range(4):
		hole_patterns.append(randi_range(0,1))
	
	for i in get_children():
		holes.append(i)
	
	hole_00.finishMole.connect(_finished_mole)
	hole_01.finishMole.connect(_finished_mole)
	hole_02.finishMole.connect(_finished_mole)
	hole_03.finishMole.connect(_finished_mole)
	
	print(hole_patterns)
	hole_patterns = _create_pattern()
	print(hole_patterns)
	pop_moles()

func _create_pattern() -> Array:
	hole_patterns.clear()
	for i in range(4):
		hole_patterns.append(randi_range(0,1))
	return hole_patterns

func _process(_delta):
	
	if active_moles <= 0:
		hole_patterns = _create_pattern()
		_create_moles()
		pop_moles()


# Algorithm that takes array an puts moles in order
func pop_moles() -> void:
	for i in holes.size():
		if hole_patterns[i] == 1:
			holes[i].show_mole()
			active_moles += 1
		else:
			holes[i].hide_mole()

# not correct way to create a algorithm for creating a dict with 
# mole patterns
func show_moles_dict(dict : Dictionary) -> void:
	for i in range(4):
		var cur = "hole_0" + str(i)
		for j in range(4):
			holes_dict[cur].append(randi_range(0,1))

	for p_I in dict.keys():
		for mole in dict[p_I]:
			if mole == 1:
				holes[mole].show_mole()

func _finished_mole() -> void:
	for i in range(4):
		holes[i]._reset_hole_status()
	
	active_moles -= 1

func _create_moles() -> void:
	for j in range(4):
		if hole_patterns[j] == 1:
			holes[j].create_mole()
			active_moles += 1
