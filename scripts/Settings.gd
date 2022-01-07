extends Control

#Active/Désactive le plein écran
func _on_FullScreenButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

#Bouton pour changer l'arrière-plan du jeu
func _on_CustomizeButton_pressed():
	$FileDialog.popup()

func _on_FileDialog_file_selected(path):
	Global.bg_changed = true
	Global.bg_path = path

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
