extends Control

var recipe_name:String
var ingredients:Array
var total_time: float
@onready var timer = $timer
var is_completed:bool

func init(args):
	recipe_name = args["name"]
	ingredients = args["ingredients"]
#	total_time = args["timer"]
	total_time = 5
	print(recipe_name)
	print(ingredients)
	print(total_time)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = total_time
	print(timer.wait_time)
	timer.start() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(timer.time_left)
	pass

func _on_timer_timeout():
	timer.stop() # Replace with function body.
	print(recipe_name) # Replace with function body.
	print("Se ha acabado")
