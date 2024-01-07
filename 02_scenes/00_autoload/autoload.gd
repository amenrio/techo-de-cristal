extends Node

var globalScore: int = 0
var totalIngredients: int = 0
var totalComandas: int = 0
var result:String

var comandas_min : int = 3
var comandas_optimo : int = 5

var screenResolution = Vector2(1200,900)

var windowChanger : int = 0

const WINDOW_MODE_ARRAY : Array[String] = [
	"Full Screen",
	"Windowed"
]

func _changeWindowMode(index: int) -> void:
	match index:
		0: #WINDOWED
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(screenResolution)
		1: #FULLSCREEN
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func reset_score():
	globalScore = 0
	totalIngredients = 0
	totalComandas = 0
	
#func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#	elif Input.is_action_just_pressed('fire'):
#		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	if Input.is_action_just_pressed("ToggleScreen"):
		_changeWindowMode(windowChanger%2)
		windowChanger += 1
#	if Input.is_action_just_pressed("ToggleScreen") and DisplayServer.WINDOW_MODE_FULLSCREEN:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
#		DisplayServer.window_set_size(Vector2(1200, 900))
#	elif Input.is_action_just_pressed("ToggleScreen") and DisplayServer.WINDOW_MODE_WINDOWED:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func load_result_screen(completed):
	if completed < comandas_min:
		Autoload.result = "BAD"
	elif completed < comandas_optimo:
		Autoload.result = "NORMAL"
	elif completed >= comandas_optimo:
		Autoload.result = "EXCELENT"
	get_tree().change_scene_to_file("res://02_scenes/04_screens/results_screen.tscn")
