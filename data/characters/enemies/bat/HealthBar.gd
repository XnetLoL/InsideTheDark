extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Stats_health_changed(value):
	self.value = value
	if (self.value < max_value):
		visible = true
	else:
		visible = false


func _on_Stats_max_health_changed(value):
	max_value = value
