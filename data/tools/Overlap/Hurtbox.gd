extends Area2D

const HitEffect = preload("res://data/assets/VFX/HitEffect/HitEffect.tscn")

var invincible = false setget set_invincible

signal invincibility_started
signal invincibility_ended

onready var timer = $Timer;

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func _on_Timer_timeout():
	self.invincible = false

func _on_Hurtbox_invincibility_started():
	$CollisionShape2D.set_deferred("disabled", true)

func _on_Hurtbox_invincibility_ended():
	$CollisionShape2D.set_deferred("disabled", false)

func create_hit_effect(node):
	var effect = HitEffect.instance()
	node.add_child(effect)
