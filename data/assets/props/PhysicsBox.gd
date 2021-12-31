extends Box
class_name PhysicsBox

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 20
var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	#velocity = move_and_slide(velocity)

func push(velocity: Vector2) -> void:
	self.velocity = velocity
	move_and_slide(velocity, Vector2())
