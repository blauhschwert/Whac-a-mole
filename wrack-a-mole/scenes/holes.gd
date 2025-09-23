class_name Holes
extends Node

signal mole_wracked(points : int)

# All the holes that got a mole
@onready var hole_00 : Hole = $Hole_00
@onready var hole_01 : Hole = $Hole_01
@onready var hole_02 : Hole = $Hole_02
@onready var hole_03 : Hole = $Hole_03

var holes_dict = {
	"hole_00" : [],
	"hole_01" : [],
	"hole_02" : [],
	"hole_03" : []
}

var holes = []
var hole_patterns = [] # Mole Pattern for game
var moles_in_game : int = 0

var mole_points = [10,15,35]

func _ready() -> void:
	randomize()
	for i in range(4):
		hole_patterns.append(randi_range(0,1))
	
	for i in get_children():
		holes.append(i)
	
	hole_00.moleClear.connect(_finished_mole)
	hole_01.moleClear.connect(_finished_mole)
	hole_02.moleClear.connect(_finished_mole)
	hole_03.moleClear.connect(_finished_mole)
	
	
	hole_00.moleCreated.connect(_add_moles)
	hole_01.moleCreated.connect(_add_moles)
	hole_02.moleCreated.connect(_add_moles)
	hole_03.moleCreated.connect(_add_moles)
	
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
	
	if moles_in_game <= 0:
		hole_patterns = _create_pattern()
		_create_moles()
		pop_moles()


# Algorithm that takes array an puts moles in order
func pop_moles() -> void:
	for i in holes.size():
		if hole_patterns[i] == 1:
			holes[i].create_mole()
			moles_in_game += 1

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
	
	moles_in_game -= 1
	var score : int = mole_points[randi() % mole_points.size()]
	emit_signal("mole_wracked",score)

func _create_moles() -> void:
	for j in range(4):
		if hole_patterns[j] == 1:
			holes[j].create_mole()
			moles_in_game += 1

func _add_moles() -> void:
	moles_in_game += 1
