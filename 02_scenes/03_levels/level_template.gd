extends Node2D

# Called when the node enters the scene tree for the first time.
var special_drops = ['2shot','3shot','health']
@export var time_limit: float = 10
@onready var pause_menu = $player/Camera2D/PauseMenu
var paused = false
#@onready var timer_label = $player/Camera2D/Label
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	var player = $player
	var player_start = $player_start
	player.position = player_start.position
	
func _process(_delta):
	if Input.is_action_just_pressed('pause'):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
		
func pickup_system(enemy):
	var new_position = enemy.position
	var pick_up = enemy.loot.instantiate()
	pick_up._name = enemy._name
	pick_up.position = new_position
	call_deferred("add_child",pick_up)
#	var special_chance = randi_range(1,100)
#	if special_chance <= 15:
#		extra_drop(enemy,new_position)
#
func extra_drop(enemy,new_position):
	var extra_pickup = enemy.loot.instantiate()
	extra_pickup._class = 'modifiers'
	extra_pickup._name = special_drops[randi_range(0,2)]
	extra_pickup.position = new_position + Vector2(32,32)
	call_deferred("add_child",extra_pickup)
	print("Extra_item {type}".format({'type':extra_pickup._name}))

func _on_level_timer_timeout():
	get_tree().paused = true# Replace with function body.
