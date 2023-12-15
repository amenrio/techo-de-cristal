extends Node

var globalScore: int = 0
var totalIngredients: int = 0
var totalComandas: int = 0
var result:String

var comandas_min : int = 3
var comandas_optimo : int = 5
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_pressed('fire'):
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		
		
func load_result_screen(completed):
	if completed < comandas_min:
		Autoload.result = "BAD"
	elif completed < comandas_optimo:
		Autoload.result = "NORMAL"
	elif completed >= comandas_optimo:
		Autoload.result = "EXCELENT"
	get_tree().change_scene_to_file("res://02_scenes/04_screens/results_screen.tscn")
