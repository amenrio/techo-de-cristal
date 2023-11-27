extends Area2D

var recipes_file = "res://04_game/recipes.json"
var recipes_text:String
var recipes_dict:Dictionary
var total_recipes:int

var comandas_nivel: Array

@onready var level_instance = get_tree().current_scene

func _get_recipes():
	recipes_text = FileAccess.get_file_as_string(recipes_file)
	recipes_dict = JSON.parse_string(recipes_text)
	total_recipes = len(recipes_dict.keys())# Replace with function body.
#	print(total_recipes)

func get_random_recipe():
	var _recipe_index = randi_range(0,total_recipes-1)
	var _recipe_key = recipes_dict.keys()[_recipe_index]
	var recipe_todo = recipes_dict[_recipe_key]
	return recipe_todo
# FUNCION DECIR AL JUGADOR QUE COMANDAS HACE

func set_level_comandas():
	var _recipes_todo:Array = []
	var _recipe = get_random_recipe()
	return _recipe
#	print(_recipe)
#		_recipes_todo.append({recipes_dict[randi_range(0,total_recipes-1]:})
# FUNCION DE CHECKEAR LAS COMANDAS HECHAS
func get_new_comandas(number_of_comandas:int):
	var _recipes:Array = []
	for i in range(number_of_comandas):
		_recipes.append(get_random_recipe())
	return _recipes
		
# DAR NUEVAS COMANDAS
func _ready():
	var _recipes_databse = _get_recipes()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

