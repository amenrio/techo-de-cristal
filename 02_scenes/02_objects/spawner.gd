extends Node2D

@export var enemies: Array[PackedScene]

@export var spawn_timer: float = 4.0
@onready var current_level = get_tree().current_scene
@onready var spawn_area = $spawn_area
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_spawn_timer_timeout():
	var new_enemy = enemies[0].instantiate()
	var spawn_position = spawn_area.position + Vector2(randf() * spawn_area.size.x, randf() * spawn_area.size.y)
	new_enemy.position = spawn_position
	current_level.add_child(new_enemy) # Replace with function body.