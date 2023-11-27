extends Control

var recipe_name:String
var ingredients:Array
var _ingredients
var total_time: float
@onready var timer = $timer
var is_completed:bool
var timed_out:bool=false

@onready var name_hud = $comanda_hbox/name
@onready var ingredients_hud = $comanda_hbox/ingredients
@onready var timer_hud = $comanda_hbox/timer

func init(args):
	recipe_name = args["name"]
	ingredients = args["ingredients"]
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
	ingredients_hud.text = str(ingredients)
	timer_hud.text = str(int(timer.time_left))
	if len(ingredients)<=0:
		is_completed=true

func _on_timer_timeout():
	timer.stop()
	if not is_completed:
		timed_out = true
		print("%s comanda not done in time" % recipe_name)# Replace with function body.
		
