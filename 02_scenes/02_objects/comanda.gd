extends Control

var recipe_name:String
#var ingredients:Array
var ingredients:Dictionary
var _ingredients
var completed_ingredients:Dictionary
var sorted_completed_ingredients:Dictionary
var total_time: float
@onready var timer = $timer
var is_completed:bool
var timed_out:bool=false
@onready var completed_hud = $comanda_hbox/completed_ingredients
@onready var name_hud = $comanda_hbox/name
@onready var ingredients_hud = $comanda_hbox/ingredients
@onready var timer_hud = $comanda_hbox/timer

func init(args):
	recipe_name = args["name"]
	ingredients = sort(args["ingredients"])
#	total_time = args["timer"]
	total_time = int(args["timer"])

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = total_time
	_ingredients = ingredients
	init_hud()
	timer.start() # Replace with function body.
	
func init_hud():
	name_hud.text = recipe_name
	ingredients_hud.text = str(ingredients)
	timer_hud.text = str(total_time)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sorted_completed_ingredients = sort(completed_ingredients)
	ingredients_hud.text = str(ingredients)
	timer_hud.text = str(int(timer.time_left))
	completed_hud.text = str(sorted_completed_ingredients)
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
		print("%s comanda not done in time" % recipe_name)# Replace with function body.
		
