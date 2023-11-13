extends "res://02_scenes/03_levels/level_template.gd"

@onready var lvl_timer = $level_timer
@onready var timer_label = $player/Camera2D/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var string = "Time Left: %s" % lvl_timer.wait_time
	timer_label.text = string
