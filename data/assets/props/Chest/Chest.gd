extends Node2D

export(NodePath) var trigger


# Called when the node enters the scene tree for the first time.
func _ready():
	trigger = get_node_or_null(trigger)
	trigger.connect("triggered", self, "_on_trigger")


func _on_trigger():
	$Opened.visible = !$Opened.visible
