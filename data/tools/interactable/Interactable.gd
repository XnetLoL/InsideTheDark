extends Area2D

export(String) var timeline
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")
	$DialogManager.timeline = timeline


func _input(event):
	if event.is_action_pressed('pickup') and active:
		var dialog = $DialogManager.start_dialog()

func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true

func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
