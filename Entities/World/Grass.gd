extends Node2D

onready var animatedSprite = $AnimatedSprite

func _ready():
	animatedSprite.frame = 0

func _on_AnimatedSprite_animation_finished():
	queue_free()

func _on_Hurtbox_area_entered(area):
	
	if area.get_name() != "SwordHitbox":
		print(area.get_name())
		return
	
	$Sprite.visible = false
	$AnimatedSprite.visible = true
	animatedSprite.play("animate")
