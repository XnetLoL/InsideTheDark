extends YSort

signal triggered
var status = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	for rune in get_children():
		rune.connect("enabled", self, "_on_trigger")


func _on_trigger(enabled):
	if enabled:
		status += 1
	else:
		status -= 1
	
	if status == 3:
		emit_signal("triggered")
