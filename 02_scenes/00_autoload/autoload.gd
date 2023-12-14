extends Node

var globalScore: int = 0
var totalIngredients: int = 0
var totalComandas: int = 0
var result:String

var comandas_min : int = 3
var comandas_optimo : int = 5


func load_result_screen(completed):
	if completed < comandas_min:
		Autoload.result = "BAD"
	elif completed < comandas_optimo:
		Autoload.result = "NORMAL"
	elif completed >= comandas_optimo:
		Autoload.result = "EXCELENT"
	get_tree().change_scene_to_file("res://02_scenes/04_screens/results_screen.tscn")
