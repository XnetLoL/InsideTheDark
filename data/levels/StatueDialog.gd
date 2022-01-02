extends Area2D

var active = false
var has_orb = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")


func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed('pickup') and active and !has_orb:
			var dialog = $DialogManager.start_dialog()
			if dialog != null:
				dialog.connect("dialogic_signal", self, "dialogic_signal_event")

func dialogic_signal_event(param):
	if param == "remove_orb":
		if get_parent().inventory != null:
			get_parent().inventory.remove_item_by_name("Orb")
			get_parent().add_orb()
		$Orb.visible = true
		has_orb = true

func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true

func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
