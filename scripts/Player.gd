extends KinematicBody2D

var bullet_ressource = preload("res://scenes/Bullet.tscn")

func _physics_process(delta):
	position.x = get_viewport().get_mouse_position().x #Suit le mouvement de la souris sur l'axe X
	if Input.is_action_pressed("click"): #Quand le clic gauche est appuyé
		var bullet = bullet_ressource.instance() #Instance en tant que noeud enfant du vaisseau
		add_child(bullet) #L'ajoute dans la scène
