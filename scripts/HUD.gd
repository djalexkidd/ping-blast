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
