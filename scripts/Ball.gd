extends KinematicBody2D

var velocity = Vector2(100,0)
var strengh = 50
const target_y = 5
const GRAVITY = 5

func _ready():
	$Strengh.text = String(strengh) #Actualise le compteur de pièces

func _physics_process(delta):
	velocity.y += GRAVITY
	move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		velocity.x *= -1
	if is_on_floor():
		velocity.y *= -1
	
	if strengh == 0:
		queue_free()

func _on_Area2D_area_entered(area):
	strengh -= 1
	_ready()
