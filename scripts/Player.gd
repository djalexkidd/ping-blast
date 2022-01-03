extends KinematicBody2D

signal lose

func _physics_process(delta):
	position.x = get_viewport().get_mouse_position().x #Suit le mouvement de la souris sur l'axe X

#Quand le carré rouge touche une balle, la partie est perdue
func _on_Area2D_area_entered(area):
	emit_signal("lose")
	queue_free()
