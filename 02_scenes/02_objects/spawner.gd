extends Node2D
@export var enemy_scene_dict: Dictionary
@export var enemies: PackedScene
@export var enemy_names: Array[String]
@export var spawn_timer: float = 4.0
@onready var current_level = get_tree().current_scene
@onready var player = get_parent().get_node("player")
@onready var spawn_min = $area.global_position
@onready var spawn_max = $area.global_position + $area.size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_spawn_timer_timeout():
	var new_enemy_name = enemy_scene_dict.keys()[randi_range(0,2)]
	var new_enemy_scene = load(enemy_scene_dict[new_enemy_name])
	var new_enemy = new_enemy_scene.instantiate()
#	var new_enemy = enemies.instantiate()
	new_enemy._name = new_enemy_name
	var spawn_position = Vector2(randf_range(spawn_min.x,spawn_max.x),randf_range(spawn_min.y,spawn_max.y))
	new_enemy.position = spawn_position
	current_level.add_child(new_enemy)
	new_enemy.get_node('HealthComponent').connect('death',current_level.pickup_system) # Replace with function body.
