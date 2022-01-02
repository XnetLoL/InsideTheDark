extends KinematicBody2D

export(String) var item_name = "Potion"

const ACCELERATION = 460
const MAX_SPEED = 180
var velocity = Vector2.ZERO

var player = null
var being_picked_up = false

func _ready():
	$Item.item_name = item_name

func _physics_process(delta):
	if get_parent() != null and get_parent().is_visible():
		$CollisionShape2D.disabled = false
	if being_picked_up:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		
		var distance = global_position.distance_to(player.global_position)
		if distance < 4:
			if item_name == "Orb":
				Dialogic.set_variable("orbs", int(Dialogic.get_variable("orbs"))+1)
			if item_name == "Relic":
				get_tree().change_scene("res://data/levels/GameOver.tscn")
			queue_free()
	velocity = move_and_slide(velocity)

func pick_up_item(body):
	player = body
	being_picked_up = true

func get_item():
	return $Item
