extends Node2D

func _on_b_xogar_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/controls_pregame_screen.tscn")

func _on_b_creditos_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/credits_screen.tscn")

func _on_b_controles_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/controls_screen.tscn")

func _on_b_sair_pressed():
	get_tree().quit()
