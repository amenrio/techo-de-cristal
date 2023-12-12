extends Node2D



func _on_b_resultados_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/results_screen.tscn")


func _on_b_pausa_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/pause_screen.tscn")
