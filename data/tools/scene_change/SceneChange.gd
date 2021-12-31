extends Area2D

export(String) var scene_path


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SceneChange_body_entered(body):
	if body.get_name() == 'Player':
		get_tree().change_scene("res://data/levels/"+scene_path+".tscn")
