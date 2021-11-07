extends Node2D

var bullet_ressource = preload("res://scenes/Bullet.tscn")

func _physics_process(delta):
	if Input.is_action_pressed("click"): #Quand le clic gauche est appuyé
		var bullet = bullet_ressource.instance() #Instance en tant que noeud
		add_child(bullet) #L'ajoute dans la scène
