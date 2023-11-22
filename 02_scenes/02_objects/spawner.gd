extends Node2D

@export var enemies: PackedScene
@export var enemy_names: Array[String]
@export var spawn_timer: float = 4.0
@onready var current_level = get_tree().current_scene
@onready var player = get_parent().get_node("player")
@onready var spawn_area = $area
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_spawn_timer_timeout():
	var new_enemy = enemies.instantiate()
	new_enemy._name = enemy_names[randi_range(0,2)]
	var spawn_position = Vector2.ZERO
	var valid_pos = false
	spawn_position = $weight.global_position + Vector2(100,0).rotated(randf_range(0, 2*PI))
#	print(valid_pos)
#	while not valid_pos:
##		if spawn_position
	new_enemy.position = spawn_position
	current_level.add_child(new_enemy)
	new_enemy.get_node('HealthComponent').connect('death',current_level.pickup_system) # Replace with function body.
