extends Control

var score = 0

func _on_Ball_add_score():
	score += 10
	$ScoreValue.text = String(score) #Actualise le compteur de pièces
