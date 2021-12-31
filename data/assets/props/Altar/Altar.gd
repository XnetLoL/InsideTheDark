extends Node2D


signal triggered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	var box : = body as Box
	if box:
		$Runes.visible = true
		emit_signal("triggered")


func _on_Area2D_body_exited(body):
	var box : = body as Box
	if box:
		$Runes.visible = false
		emit_signal("triggered")
