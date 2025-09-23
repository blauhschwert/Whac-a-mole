class_name Holes
extends Node

# All the holes that got a mole
@onready var hole_00 : Hole = $Hole_00
@onready var hole_01 : Hole = $Hole_01
@onready var hole_02 : Hole = $Hole_02
@onready var hole_03 : Hole = $Hole_03

var holes : Array[Hole] = []
var moles : Array[Mole] = []
var hole_patterns = [] # Mole Pattern for game
var moles_in_game : int = 0



func _ready() -> void:
	randomize()
	for i in range(4):
		hole_patterns.append(randi_range(0,1))
	
	for hole_n in get_children():
		if hole_n is Hole:
			holes.append(hole_n)
	
	for n in holes:
		if n.has_signal("moleCreated"):
			n.moleCreated.connect(_add_moles)
	
	hole_patterns = _create_pattern()
	print(hole_patterns)
	print(hole_patterns)
	pop_moles()
	
	for m in holes:
		if m.mole != null:
			moles.append(m.mole)
	
	for h in moles:
		if h.has_signal("finishMole"):
			h.connect("finishMole",Callable(self,"_finished_mole"),CONNECT_ONE_SHOT)
		

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
			moles.append(holes[i].mole)

func _finished_mole() -> void:
	moles_in_game -= 1

func _create_moles() -> void:
	for j in range(4):
		if hole_patterns[j] == 1:
			holes[j].create_mole()
			_add_moles()

func _add_moles() -> void:
	moles_in_game += 1
