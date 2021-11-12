extends Control

var score = 0

func _ready():
	$HighScoreValue.text = String(Global.highscore)

func _on_Ball_add_score():
	score += 10
	$ScoreValue.text = String(score) #Actualise le compteur de pièces

func get_score():
	return score
