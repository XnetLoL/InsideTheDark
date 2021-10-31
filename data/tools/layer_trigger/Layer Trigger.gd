extends Area2D


export var layer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Layer_Trigger_body_entered(body):
	if body is TileMap or get_parent() == body.get_parent():
		return
	print(body.get_name() + "has entered")
	body.set_collision_layer(pow(2, layer))
	body.set_collision_mask(pow(2, layer))
	body.get_node("Sprite").set_light_mask(pow(2, layer))
	
	if body.get_node("Light2D") != null:
		body.get_node("Light2D").set_item_cull_mask(pow(2, layer))
		#body.get_node("Light2D").set_item_shadow_cull_mask(pow(2, layer))
		body.get_node("Light2D").set_light_mask(pow(2, layer))
#	body.set_z_index(layer)

	body.get_parent().remove_child(body)
	get_parent().call_deferred("add_child", body)


func _on_Layer_Trigger_body_exited(body):
	if body is TileMap or get_parent() == body.get_parent():
		return
	print(body.get_name() + "has exited")
