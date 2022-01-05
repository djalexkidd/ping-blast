extends Node2D

var can_shoot = true #Variable pour limiter le "fire rate"
var bullet_ressource = preload("res://scenes/Bullet.tscn")
var ball_ressource = preload("res://scenes/Ball.tscn")
var ball_small_ressource = preload("res://scenes/Ball_small.tscn")
var ball_number = 0 #Numéro de la balle
const TRACKS = [ 'Track1', 'Track2', 'Track3' ] #Musiques aléatoires

#Charge une musique aléatoire
#La musique doit être mise dans /assets/sounds/bgm/ au format OGG
func _ready():
	var rand_nb = randi() % TRACKS.size()
	var audiostream = load('res://assets/sounds/bgm/' + TRACKS[rand_nb] + '.ogg')
	get_node("BGM").set_stream(audiostream)
	$BGM.play()

func _physics_process(delta):
	if Input.is_action_pressed("click") and can_shoot: #Quand le clic gauche est appuyé
		var bullet = bullet_ressource.instance() #Instance en tant que noeud
		add_child(bullet) #L'ajoute dans la scène
		can_shoot = false
		$Timer.start()

#Timer pour limiter la fréquence de tir car sinon le jeu est trop facile
# Fire Rate == 0.1 secondes
func _on_Timer_timeout():
	can_shoot = true

#Quand le joueur pert
func _on_Player_lose():
	#Ne peut plus tirer
	$Timer.queue_free()
	can_shoot = false
	$BGM.stop() #La musique s'arrête
	$GameOverSound.play() #Le son de game over se joue
	$CanvasLayer/HUD/GameOverLabel.show() #Le texte "GAME OVER" s'affiche
	#Si meilleur score
	if $CanvasLayer/HUD.score > Global.highscore:
		$NewHighScoreSound.play() #Joue le son du High Score
		$CanvasLayer/HUD/NewHighScoreLabel.show() #Le texte "Nouveau Record !" s'affiche
		save_highscore() #Sauvegarde le record

#HOLY SHIT! C'est bordelique!
#Spawn deux petites balles
func _on_Ball_spawn_small():
	#Une à gauche
	toast()
	get_node("ball_small" + str(ball_number)).set_position(Vector2(get_node("ball" + str(ball_number - 1)).position))
	get_node("ball_small" + str(ball_number)).position.x -= 50
	#Une à droite
	toast()
	get_node("ball_small" + str(ball_number)).set_position(Vector2(get_node("ball" + str(ball_number - 2)).position))
	get_node("ball_small" + str(ball_number)).position.x += 50
	
	#En gros ça doit faire téléporter les nouvelles boules à la précédente, pour faire un effet de division mais ça marche mal

#Incrémente l'identifiant de la boule
func toast():
	var ball_small = ball_small_ressource.instance() #Instance en tant que noeud
	ball_number += 1
	ball_small.set_name("ball_small" + str(ball_number))
	add_child(ball_small) #L'ajoute dans la scène

# Spawn une balle toutes les 10 secondes
func _on_SpawnNewTimer_timeout():
	var ball = ball_ressource.instance() #Instance en tant que noeud
	ball_number += 1
	ball.set_name("ball" + str(ball_number))
	add_child(ball) #L'ajoute dans la scène
	get_node("ball" + str(ball_number)).position = Vector2(640, 320)

# Retourne au menu principal quand le son de Game Over est fini
func _on_GameOverSound_finished():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

# Sauvegarde le meilleur score
func save_highscore():
	var data = {
		"highscore" : $CanvasLayer/HUD.get_score()
	}
	
	var save_file = File.new()
	save_file.open("user://highscores.json", File.WRITE)
	save_file.store_line(to_json(data))
	save_file.close()
