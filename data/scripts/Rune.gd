extends Sprite

export(NodePath) var trigger

signal enabled(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	trigger = get_node_or_null(trigger)
	if trigger != null:
		trigger.connect("triggered", self, "_on_trigger")

func _on_trigger():
	visible = !visible
	emit_signal("enabled", visible)
