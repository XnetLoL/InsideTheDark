extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 300

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var angles = false

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState= animationTree.get("parameters/playback")

func _ready():
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
	
	if Input.is_action_pressed("shield"):
		speed *= 0.1
		$ShieldSprite.visible = true
	else:
		$ShieldSprite.visible = false
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector) 
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		if angles and input_vector.y == 0:
			velocity = velocity.move_toward(input_vector.normalized().rotated(deg2rad(35)) * speed, ACCELERATION * delta)
		else:
			velocity = velocity.move_toward(input_vector.normalized() * speed, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	animationState.travel("Attack") 

func attack_animation_finished():
	state = MOVE
