extends Area2D

var active = false
signal triggered

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")

func _input(event):
	if event.is_action_pressed('pickup') and active:
		$Up.visible = !$Up.visible
		emit_signal("triggered")

func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true

func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
