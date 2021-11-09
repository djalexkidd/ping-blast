extends KinematicBody2D

const speed = 700 #Vitesse
var velocity = Vector2()

func _ready():
	set_position(get_node("/root/Game/Player").get_position() - Vector2(0, 50))

func _physics_process(delta):
	velocity.y = -speed #La balle se déplace vers le haut
	velocity = move_and_slide(velocity)

func _on_Timer_timeout():
	queue_free()
