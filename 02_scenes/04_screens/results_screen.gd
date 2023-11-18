extends Node2D


func _on_b_menu_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/menu_screen.tscn")


func _on_b_reintentar_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/game_screen.tscn")
