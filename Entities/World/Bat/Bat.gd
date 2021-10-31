extends KinematicBody2D

var knockback = Vector2.ZERO
onready var stats = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	if area.get_name() != "SwordHitbox":
		return
	stats.health -= 1
	
	var vector = (position - area.get_owner().position).normalized()
	knockback = vector * 180

func _on_Stats_no_health():
	queue_free()
