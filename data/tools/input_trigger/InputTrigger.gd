extends Area2D

export(Vector2) var direction



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_InputTrigger_body_entered(body):
	if body.get_name() == 'Player':
		body.set_cinematic_mode(direction)


func _on_InputTrigger_body_exited(body):
	if body.get_name() == 'Player':
		body.set_cinematic_mode(false)
		$CollisionShape2D.set_deferred('disabled', true)
		$StaticBody2D/CollisionShape2D.set_deferred('disabled', false)
		if get_node_or_null('DialogNode') == null:
			get_tree().paused = true
			var dialog = Dialogic.start('NPC-1')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false
