extends Node2D

const SlotClass = preload("res://data/ui/Inventory/Slot.gd")
onready var inventory_slots = $GridContainer
var holding_item = null
var is_paused = false setget set_is_paused

# Called when the node enters the scene tree for the first time.
func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item:
					slot.put_in_slot(holding_item)
					holding_item = null
				else:
					var temp_item = slot.item
					slot.pick_from_slot()
					temp_item.global_position = event.global_position
					slot.put_in_slot(holding_item)
					holding_item = temp_item
			elif slot.item:
				holding_item = slot.item
				slot.pick_from_slot()
				holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func search_item(item_name):
	for slot in $GridContainer.get_children():
		if slot.has_item(item_name):
			return true
	return false

func add_item(item):
	for slot in $GridContainer.get_children():
		if slot.add_item(item):
			return

func remove_item_by_name(item_name):
	for slot in $GridContainer.get_children():
		if slot.has_item(item_name):
			slot.remove_item()

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		set_is_paused(!is_paused)

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
