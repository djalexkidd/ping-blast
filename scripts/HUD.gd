extends Control

var score = 0

#Charge le high score
func _ready():
	$HighScoreValue.text = String(Global.highscore)

#Ajoute 10 points quand une boule est touchée :lenny:
func _on_Ball_add_score():
	score += 10
	$ScoreValue.text = String(score) #Actualise le compteur de pièces

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
