extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		#self.is_paused != is_paused
		set_is_paused(!is_paused)

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_ResumeButton_pressed():
	$AudioStreamPlayer.play()
	set_is_paused(false)


func _on_QuitButton_pressed():
	$AudioStreamPlayer.play()
	set_is_paused(false)
	get_tree().change_scene("res://data/levels/Menu.tscn")
