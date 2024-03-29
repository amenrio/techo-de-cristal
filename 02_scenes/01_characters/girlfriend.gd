extends Area2D

var recipes_file = "res://04_game/recipes_v02.json"
var dialog_file = "res://04_game/girlfriend_dialog.json"
var dialog_dict:Dictionary
var recipes_text:String
var recipes_dict:Dictionary
var total_recipes:int
@onready var interact_sprite = $interact_sprite 
@onready var dialogue_box = $dialogue_box
@onready var dialog_label = $dialogue_box/MarginContainer/dialogue
var comandas_nivel: Array

@onready var player_instance = get_tree().get_first_node_in_group('player')

@onready var level_instance = get_tree().current_scene

func _get_dialog():
	dialog_file = FileAccess.get_file_as_string(dialog_file)
	dialog_dict = JSON.parse_string(dialog_file)
	
func _get_recipes():
	recipes_text = FileAccess.get_file_as_string(recipes_file)
	recipes_dict = JSON.parse_string(recipes_text)
	total_recipes = len(recipes_dict.keys())# Replace with function body.
#	#print(total_recipes)
func get_random_dialog_from_context(context):
	var _index = randi_range(0,len(dialog_dict[context])-1)
	var dialog = dialog_dict[context][_index]
	return dialog
	
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
#	#print(_recipe)
#		_recipes_todo.append({recipes_dict[randi_range(0,total_recipes-1]:})
# FUNCION DE CHECKEAR LAS COMANDAS HECHAS
func get_new_comandas(number_of_comandas:int):
	var _recipes:Array = []
	for i in range(number_of_comandas):
		_recipes.append(get_random_recipe())
	return _recipes
	
func show_dialog():
	var dialog_phrase = get_random_dialog_from_context("new_recipes")
	dialog_label.text = dialog_phrase
	dialogue_box.show()
	await get_tree().create_timer(5).timeout
	dialogue_box.hide()
# DAR NUEVAS COMANDAS

func _ready():
	var _recipes_databse = _get_recipes()
	_get_dialog()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if len(player_instance.objetivos) < 1:
		interact_sprite.show()
	else:
		interact_sprite.hide()

