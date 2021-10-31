extends KinematicBody2D


var velocity = Vector2.ZERO
const FRICTION = 5000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.as


func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
