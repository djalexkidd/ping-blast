extends Node2D

var can_shoot = true
var bullet_ressource = preload("res://scenes/Bullet.tscn")

func _physics_process(delta):
	if Input.is_action_pressed("click") and can_shoot: #Quand le clic gauche est appuyé
		var bullet = bullet_ressource.instance() #Instance en tant que noeud
		add_child(bullet) #L'ajoute dans la scène
		can_shoot = false
		$Timer.start()

func _on_Timer_timeout():
	can_shoot = true

func _on_Player_lose():
	$BGM.stop()
	$GameOverSound.play()
	$HUD/GameOverLabel.show()
