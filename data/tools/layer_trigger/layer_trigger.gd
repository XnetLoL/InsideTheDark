extends Node2D

export(NodePath) var layer1
export(NodePath) var layer2

var light_value = 0
var player_moving = 0 #TODO: change it to a boolean

func _ready():
	layer1 = get_node(layer1)
	layer2 = get_node(layer2)


func _on_LowerTrigger_body_entered(body):
	pass

func _on_UpperTrigger_body_entered(body):
	pass

func update_masks(body):
	if body is TileMap or body is StaticBody2D:
		return
	if player_moving > 0: 
		player_moving -= 1
		return 
	
	var light_value = pow(2, layer1.z_index) + pow(2, layer2.z_index)
	
	if body.has_node("Sprite"):
		body.get_node("Sprite").set_light_mask(light_value)
	if body.has_node("Lantern"):
		#body.get_node("Lantern").set_item_cull_mask(light_value)
		body.get_node("Lantern").set_item_shadow_cull_mask(light_value)
		body.get_node("Lantern").set_light_mask(light_value)

func _on_LowerTrigger_body_exited(body):
	update_layer(body, layer1)

func _on_UpperTrigger_body_exited(body):
	update_layer(body, layer2)

func update_layer(body, layer):
	if body is TileMap or body is StaticBody2D:
		return
	
	var value = pow(2, layer.z_index)
	body.set_collision_layer(value)
	body.set_collision_mask(value)
	
	if layer != body.get_parent():
		player_moving = 2
		print(value)
		light_value = value
		body.get_parent().remove_child(body)
		layer.call_deferred("add_child", body)

func _on_TriggerMask_body_exited(body):
	if body is TileMap or body is StaticBody2D:
		return
	if player_moving > 0:
		player_moving -= 1
		return 
	print("changing")
	print(light_value)
	if body.has_node("Sprite"):
		body.get_node("Sprite").set_light_mask(light_value)
	if body.has_node("Lantern"):
		#body.get_node("Lantern").set_item_cull_mask(light_value)
		body.get_node("Lantern").set_item_shadow_cull_mask(light_value)
		body.get_node("Lantern").set_light_mask(light_value)

func _on_TriggerMask_body_entered(body):
	update_masks(body)
