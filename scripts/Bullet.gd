extends KinematicBody2D

const speed = 700 #Vitesse
var velocity = Vector2()

func _physics_process(delta):
	velocity.y = -speed #La balle se déplace vers le haut
	velocity = move_and_slide(velocity)
