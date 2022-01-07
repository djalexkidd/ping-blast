extends Control

func _ready():
	load_highscore() #Charge le meilleur score
	if !Global.leaderboard_enabled:
		$LeaderboardButton.queue_free()

#Bouton pour jouer au jeu
func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")

#Bouton pour quitter le jeu
func _on_QuitButton_pressed():
	get_tree().quit()

#Cette fonction charge les meilleurs temps
#Sous GNU/Linux le fichier se situe dans /home/$USER/.local/share/godot/app_userdata/Ping Blast/
func load_highscore():
	var save_file = File.new()
	if not save_file.file_exists("user://highscores.json"):
		return #Ne fait rien si le fichier n'existe pas

	save_file.open("user://highscores.json", File.READ) #Ouvre le fichier
	var json_str = save_file.get_as_text()
	var game_data = JSON.parse(json_str).result
	Global.highscore = game_data.highscore #Met la première ligne du fichier dans une variable "highscore"
	$TopValue.text = String(Global.highscore) #Change le texte
	save_file.close() #Ferme le fichier

func _on_SettingsButton_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_LeaderboardButton_pressed():
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
