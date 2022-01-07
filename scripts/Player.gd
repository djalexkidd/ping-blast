extends KinematicBody2D

var invincible

signal lose

func _physics_process(delta):
	position.x = get_viewport().get_mouse_position().x #Suit le mouvement de la souris sur l'axe X

#Quand le carré rouge touche une balle, la partie est perdue
func _on_Area2D_area_entered(area):
	if !invincible:
		emit_signal("lose")
		queue_free()

func bonus():
	invincible = true
	modulate = Color(1,1,1,0.25)
	$Invinciblility.start()
	$InvinciblilityGet.play()

func _on_Invinciblility_timeout():
	invincible = false
	modulate = Color(1,1,1,1)
