extends Node2D

export(NodePath) var inventory

signal triggered
var orbs = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = get_node_or_null(inventory)


func add_orb():
	orbs += 1
	if orbs >= 4:
		emit_signal("triggered")
