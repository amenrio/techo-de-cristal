extends Node2D
@export var enemy_scene_dict: Dictionary
@export var enemies: PackedScene
@export var enemy_names: Array[String]
@export var spawn_timer: float = 4.0
@onready var timer_node = $timer
@onready var current_level = get_tree().current_scene
@onready var player = get_parent().get_node("player")
@onready var spawn_min = $area.global_position
@onready var spawn_max = $area.global_position + $area.size

var spawn_count: int = 0
@export var limit: int = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	timer_node.wait_time = spawn_timer
	#print(timer_node.wait_time)	
	
func _on_spawn_timer_timeout():
	if spawn_count < limit:
		var new_enemy_name:String
		var spawn_weight = randi_range(0,100)
		if spawn_weight < 75:
			new_enemy_name = enemy_names[0]
		elif spawn_weight < 90:
			new_enemy_name = enemy_names[1]
		elif spawn_weight >= 90:
			new_enemy_name = enemy_names[2]
		var new_enemy_scene = load(enemy_scene_dict[new_enemy_name])
		var new_enemy = new_enemy_scene.instantiate()
	#	var new_enemy = enemies.instantiate()
		new_enemy._name = new_enemy_name
		var spawn_position = Vector2(randf_range(spawn_min.x,spawn_max.x),randf_range(spawn_min.y,spawn_max.y))
#		var test_result = get_world_2d().direct_space_state.intersect_point(spawn_position)
#		#print(test_result)
		new_enemy.position = spawn_position
		current_level.add_child(new_enemy)
		new_enemy.get_node('HealthComponent').connect('death',current_level.pickup_system) # Replace with function body.
		spawn_count += 1
		new_enemy.get_node('HealthComponent').connect('death',queue_spawner) # Replace with function body.
		
func queue_spawner(_parent):
	spawn_count-=1

