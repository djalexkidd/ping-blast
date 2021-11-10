extends KinematicBody2D

var velocity = Vector2(100,0)
const target_y = 5
const GRAVITY = 5

func _physics_process(delta):
	velocity.y += GRAVITY
	move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		velocity.x *= -1
	if is_on_floor():
		velocity.y *= -1
