extends Control

func _ready():
	load_highscore()

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

#Cette fonction charge les meilleurs temps
#Sous GNU/Linux le fichier se situe dans /home/$USER/.local/share/godot/app_userdata/Wesh Bouée/
func load_highscore():
	var save_file = File.new()
	if not save_file.file_exists("user://highscores.json"):
		return #Ne fait rien si le fichier n'existe pas

	save_file.open("user://highscores.json", File.READ) #Ouvre le fichier
	var json_str = save_file.get_as_text()
	var game_data = JSON.parse(json_str).result
	Global.highscore = game_data.highscore #Met la première ligne du fichier dans une variable "highscore"
	$TopValue.text = String(Global.highscore)
	save_file.close() #Ferme le fichier

#Active/Désactive le plein écran
func _on_FullScreenButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
