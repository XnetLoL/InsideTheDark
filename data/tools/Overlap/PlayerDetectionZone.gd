extends Area2D

var player = null

func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	if body.get_name() != "Player":
		return
	player = body

func _on_PlayerDetectionZone_body_exited(body):
	if body.get_name() != "Player":
		return
	player = null
