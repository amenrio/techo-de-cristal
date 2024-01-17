extends Node2D

var pos = 0
@onready var recipeArray = [get_node("recipeChurros"), get_node("recipeTarta"), get_node("recipeGofres"), get_node("recipeZume")]

func _updateRecipe(direction):
	recipeArray[pos].hide()
	pos = (pos + direction) % len(recipeArray)
	recipeArray[pos].show()

func _on_b_continuar_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/menu_screen.tscn")

func _on_b_next_pressed():
	_updateRecipe(+1)

func _on_b_previous_pressed():
	_updateRecipe(-1)
