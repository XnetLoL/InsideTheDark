extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 300

var push_speed : = 70

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var stats = PlayerStats
var angles = false

var torch = false

onready var animationPlayer = $AnimationPlayer
onready var blinkPlayer = $BlinkAnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState= animationTree.get("parameters/playback")
onready var hurtbox = $Hurtbox

func _ready():
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true

func _physics_process(delta):
	
	match state:
		MOVE:
			move_state(delta) 
		ROLL:
			pass
		ATTACK:
			attack_state(delta)
	

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	var speed = MAX_SPEED
	
	if Input.is_action_just_pressed("shield"):
		torch = !torch
	
	if torch:
#		speed *= 0.1
#		$ShieldSprite.visible = true
		if has_node("Fire"):
			$Fire.visible = true
			$Lantern.visible = true
	else:
		$ShieldSprite.visible = false
		if has_node("Fire"):
			$Fire.visible = false
			$Lantern.visible = false
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector) 
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		if !$Footstep.playing:
			$Footstep.play()
		if angles and input_vector.y == 0:
			velocity = velocity.move_toward(input_vector.normalized().rotated(deg2rad(35)) * speed, ACCELERATION * delta)
		else:
			velocity = velocity.move_toward(input_vector.normalized() * speed, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	
	if get_slide_count() > 0:
		check_box_collision(input_vector)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	animationState.travel("Attack") 
	$Fire.visible = false

func check_box_collision(motion: Vector2) -> void:
	if abs(motion.x) + abs(motion.y) > 1:
		return
	var box : = get_slide_collision(0).collider as Box
	if box:
		box.push(push_speed * motion)

func attack_animation_finished():
	state = MOVE
	if torch:
		$Fire.visible = true

func _on_Hurtbox_area_entered(area):
	print(area.get_name())
	if area.get_name() != "EnemyHitbox":
		return
	stats.health -= 1
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect(self)


func _on_Hurtbox_invincibility_started():
	blinkPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkPlayer.play("Stop")
