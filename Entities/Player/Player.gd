extends KinematicBody2D

const ACCELERATION = 50
const MAX_SPEED = 100
const FRICTION = 16

var velocity = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector.normalized() * MAX_SPEED, ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	
	velocity = move_and_slide(velocity)