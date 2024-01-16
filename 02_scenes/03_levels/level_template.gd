extends Node2D

var special_drops = ['health','piercing','extra_shot']
@export var time_limit = 180

var paused = false
@onready var timer_node = $level_timer
@onready var gui_timer_gui = $player/GUI/cronometro/counter

var comandas_completadas : int = 0
@export var comandas_min : int = 1
@export var comandas_optimo : int = 3

func _ready():	
	Autoload.reset_score()
	var player = $player
	var player_start = $player_start
	timer_node.wait_time = time_limit
	player.position = player_start.position
	timer_node.start()
	AudioAutoload.stopIntro()
	
func _process(_delta):
	gui_timer_gui.text = str(int(timer_node.time_left))
		
func pickup_system(enemy):
	var new_position = enemy.position
	var pick_up = enemy.loot.instantiate()
	pick_up._name = enemy._name
	pick_up.position = new_position
#	print("FILE: level_template.gd - FUNC: PICKUP_SYSTEM(enemy), CALLER: DEATH SINGAL\nAdded %s pickup to the level" % pick_up._name)
	call_deferred("add_child",pick_up)
	var special_chance = randi_range(1,100)
	if special_chance <= 25:
		extra_drop(enemy,new_position)
#
func extra_drop(enemy,new_position):
	var extra_pickup = enemy.loot.instantiate()
	extra_pickup._class = 'modifiers'
	extra_pickup._name = special_drops[randi_range(0,2)]
	extra_pickup.position = new_position + Vector2(32,32)
	call_deferred("add_child",extra_pickup)

func _on_level_timer_timeout():
	var completed = get_node("player").completed_comandas.size()
	$spawner/timer.stop()
	timer_node.stop()
	Autoload.load_result_screen(completed)
