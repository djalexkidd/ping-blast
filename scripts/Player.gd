extends KinematicBody2D

var invincible

signal lose
signal multibullet
signal multibullet_stop

func _ready():
	randomize() #Initialise le générateur de nombre aléatoire

func _physics_process(delta):
	position.x = get_viewport().get_mouse_position().x #Suit le mouvement de la souris sur l'axe X

#Quand le carré rouge touche une balle, la partie est perdue
func _on_Area2D_area_entered(area):
	if !invincible:
		emit_signal("lose")
		queue_free()

func bonus():
	var percent = randf()
	if (percent > 0.5):
		invincible = true
		modulate = Color(1,1,1,0.25)
		$Invinciblility.start()
		$InvinciblilityGet.play()
	else:
		emit_signal("multibullet")
		$MultiBullet.start()
		$InvinciblilityGet.play()

func _on_Invinciblility_timeout():
	invincible = false
	modulate = Color(1,1,1,1)

func _on_MultiBullet_timeout():
	emit_signal("multibullet_stop")
