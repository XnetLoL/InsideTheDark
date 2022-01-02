extends Node2D


export(String) var timeline

func start_dialog():
	if get_node_or_null('DialogNode') == null:
			get_tree().paused = true
			var dialog = Dialogic.start(timeline)
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'end_dialog')
			add_child(dialog)
			return dialog

func end_dialog(timeline_name):
	get_tree().paused = false
