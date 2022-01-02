extends Panel

var ItemClass = preload("res://data/ui/Inventory/Item.tscn")
var item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func pick_from_slot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null

func put_in_slot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)

func add_item(new_item):
	if item == null:
		item = new_item
		item.position = Vector2(0, 0)
		item.get_parent().remove_child(new_item)
		item.visible = true
		add_child(item)
		return true
	return false

func has_item(item_name):
	if item != null and item.item_name == item_name:
		return true
	return false

func remove_item():
	item.queue_free()
	item = null
