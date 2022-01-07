extends Control

var score = 0

signal switch_bg

#Charge le high score
func _ready():
	$HighScoreValue.text = String(Global.highscore)

#Ajoute 10 points quand une boule est touchée :lenny:
func _on_Ball_add_score():
	score += 10
	$ScoreValue.text = String(score) #Actualise le compteur de pièces
	
	#Change l'arrière-plan quand le score est à chaque multiple de 5000
	if score % 5000 == 0 and !Global.bg_changed:
		change_background()

func scorebonus():
	score += 90
	_on_Ball_add_score()

func get_score():
	return score

#Met en pause le jeu quand la touche [ÉCHAP] est pressée
func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			$Sprite.show()
		else:
			$Sprite.hide()

func change_background():
	emit_signal("switch_bg")
