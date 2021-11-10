extends KinematicBody2D

func _physics_process(delta):
	position.x = get_viewport().get_mouse_position().x #Suit le mouvement de la souris sur l'axe X

func _on_Area2D_area_entered(area):
	queue_free()
