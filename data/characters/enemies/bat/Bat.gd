extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

enum {
	IDLE,
	WANDER,
	CHASE
}
var state = IDLE

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var stats = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if $WanderController.get_time_left() == 0:
				state = random_state([IDLE, WANDER])
				$WanderController.start_timer(rand_range(1, 3))
		WANDER:
			seek_player()
			if $WanderController.get_time_left() == 0:
				state = random_state([IDLE, WANDER])
				$WanderController.start_timer(rand_range(1, 3))
			var direction = global_position.direction_to($WanderController.target)
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			sprite.flip_h = velocity.x < 0
			
			if global_position.distance_to($WanderController.target) <= 4:
				state = random_state([IDLE, WANDER])
				$WanderController.start_timer(rand_range(1, 3))
			
		CHASE:
			var player = $PlayerDetectionZone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)#(player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	
	velocity = move_and_slide(velocity)

func seek_player():
	if $PlayerDetectionZone.can_see_player():
		state = CHASE

func random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Hurtbox_area_entered(area):
	if area.get_name() != "SwordHitbox":
		return
	stats.health -= 1
	$Hurtbox.create_hit_effect(self)
	
	var vector = (position - area.get_owner().position).normalized()
	knockback = vector * 180

func _on_Stats_no_health():
	$AnimatedSprite.visible = false
	$DeathEffect.frame = 0
	$DeathEffect.visible = true
	$DeathEffect.play("animate")
	$DeathEffect/Audio.play()


func _on_DeathEffect_animation_finished():
	queue_free()
