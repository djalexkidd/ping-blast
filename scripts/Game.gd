extends Node2D

var can_shoot = true
var bullet_ressource = preload("res://scenes/Bullet.tscn")
var ball_ressource = preload("res://scenes/Ball.tscn")
var ball_small_ressource = preload("res://scenes/Ball_small.tscn")
var ball_number = 0
const TRACKS = [ 'Track1', 'Track2' ]

func _ready():
	var rand_nb = randi() % TRACKS.size()
	var audiostream = load('res://assets/sounds/bgm/' + TRACKS[rand_nb] + '.wav')
	get_node("BGM").set_stream(audiostream)
	$BGM.play()

func _physics_process(delta):
	if Input.is_action_pressed("click") and can_shoot: #Quand le clic gauche est appuyé
		var bullet = bullet_ressource.instance() #Instance en tant que noeud
		add_child(bullet) #L'ajoute dans la scène
		can_shoot = false
		$Timer.start()

func _on_Timer_timeout():
	can_shoot = true

func _on_Player_lose():
	$Timer.queue_free()
	can_shoot = false
	$BGM.stop()
	$GameOverSound.play()
	$HUD/GameOverLabel.show()
	if $HUD.score > Global.highscore:
		$NewHighScoreSound.play()
		$HUD/NewHighScoreLabel.show()
		save_highscore()

func _on_Ball_spawn_small():
	toast()
	get_node("ball_small" + str(ball_number)).set_position(Vector2(get_node("ball" + str(ball_number - 1)).position))
	get_node("ball_small" + str(ball_number)).position.x -= 50
	toast()
	get_node("ball_small" + str(ball_number)).set_position(Vector2(get_node("ball" + str(ball_number - 2)).position))
	get_node("ball_small" + str(ball_number)).position.x += 50

func toast():
	var ball_small = ball_small_ressource.instance() #Instance en tant que noeud
	ball_number += 1
	ball_small.set_name("ball_small" + str(ball_number))
	add_child(ball_small) #L'ajoute dans la scène

func _on_SpawnNewTimer_timeout():
	var ball = ball_ressource.instance() #Instance en tant que noeud
	ball_number += 1
	ball.set_name("ball" + str(ball_number))
	add_child(ball) #L'ajoute dans la scène
	get_node("ball" + str(ball_number)).position = Vector2(640, 320)

func _on_GameOverSound_finished():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

# Sauvegarde le meilleur score
func save_highscore():
	var data = {
		"highscore" : $HUD.get_score()
	}
	
	var save_file = File.new()
	save_file.open("user://highscores.json", File.WRITE)
	save_file.store_line(to_json(data))
	save_file.close()
