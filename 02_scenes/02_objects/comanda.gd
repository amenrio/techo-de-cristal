extends Control

var recipe_name:String
#var ingredients:Array
var ingredients:Dictionary
var _ingredients
var completed_ingredients:Dictionary
var sorted_completed_ingredients:Dictionary
var total_time: float
var is_completed:bool
var timed_out:bool=false
var _recipe_path:String
@onready var animation_player = $AnimationPlayer
@onready var recipe_sprite = $sprite
@onready var timer = $timer
@onready var ingredient_vb = $HBoxContainer/MarginContainer/ingredients
var ingredient_instance = preload("res://02_scenes/04_screens/comanda_ingredient.tscn")
@onready var player_instance = get_tree().get_first_node_in_group('player')

func init(args):
	recipe_name = args["name"]
	ingredients = sort(args["ingredients"])
	_recipe_path = args["sprite"]
	total_time = int(args["timer"])

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("init1")
	timer.wait_time = total_time
	_ingredients = ingredients
	init_hud()
	timer.start() # Replace with function body.
	
func init_hud():
	recipe_sprite.texture = load(_recipe_path)
	for ingredient in ingredients:
		if ingredients[ingredient] > 1:
			for ing in ingredients[ingredient]:
				append_ingredient(ingredient)
				continue
		else:
			append_ingredient(ingredient)

func append_ingredient(ingredient):
	var ingredient_inst = ingredient_instance.instantiate()
	ingredient_inst.ing_sprite = ingredient
	ingredient_vb.add_child(ingredient_inst)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sorted_completed_ingredients = sort(completed_ingredients)

	if equal(ingredients, completed_ingredients):
		is_completed=true
		timer.stop()
		
func equal(lh:Dictionary, rh:Dictionary):
	var ingredient_keys = lh.keys()
	for key in ingredient_keys:
		if not rh.has(key):
			return false
		var tv = lh[key]
		if typeof(tv) == TYPE_DICTIONARY:
			if !equal(tv,	 rh[key]):
				return false
		elif tv != rh[key]:
			return false
	return true
		
func sort(dict):
	var sorted_dict = {}
	var keys = dict.keys()
	keys.sort()

	for key in keys:
		sorted_dict[key] = dict[key]
	return sorted_dict

func _on_timer_timeout():
	timer.stop()
	if not is_completed:
		timed_out = true
		print("%s comanda not done in time" % recipe_name)
		animation_player.play("exit")# Replace with function body.
		
