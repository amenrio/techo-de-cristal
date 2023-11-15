extends "res://02_scenes/03_levels/level_template.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func pickup_system(enemy):
	var new_position = enemy.position
	var pick_up = enemy.loot.instantiate()
	pick_up.position = new_position
	add_child(pick_up)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var string = "Time Left: %s" % lvl_timer.wait_time
#	timer_label.text = string
	pass
