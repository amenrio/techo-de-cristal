extends Node2D

var special_drops = ['2shot','3shot','health']
@export var time_limit = 180
@onready var pause_menu = $player/Camera2D/PauseMenu
var paused = false
@onready var timer_node = $level_timer
@onready var gui_timer_gui = $player/GUI/cronometro/counter

var comandas_completadas : int = 0
@export var comandas_min : int = 1
@export var comandas_optimo : int = 3

func _ready():
	var player = $player
	var player_start = $player_start
	timer_node.wait_time = time_limit
	player.position = player_start.position
	timer_node.start()
	
func _process(_delta):
	if Input.is_action_just_pressed('pause'):
		pauseMenu()
	gui_timer_gui.text = str(int(timer_node.time_left))
		
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
	print("FILE: level_template.gd - FUNC: PICKUP_SYSTEM(enemy), CALLER: DEATH SINGAL\nAdded %s pickup to the level" % pick_up._name)
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
	var completed = get_node("player").completed_comandas.size()
	if completed < comandas_min:
		get_tree().change_scene_to_file("res://02_scenes/04_screens/results_screen.tscn")
	elif completed < comandas_optimo:
		get_tree().change_scene_to_file("res://02_scenes/04_screens/results_screen.tscn")
	elif completed >= comandas_optimo:
		get_tree().change_scene_to_file("res://02_scenes/04_screens/results_screen.tscn")
	$spawner/timer.stop()
	timer_node.stop()
