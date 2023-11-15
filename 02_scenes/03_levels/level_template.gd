extends Node2D

# Called when the node enters the scene tree for the first time.

@export var time_limit: float = 10

#@onready var timer_label = $player/Camera2D/Label
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	var player = $player
	var player_start = $player_start
	player.position = player_start.position
	
func pickup_system(enemy):
	var new_position = enemy.position
	var pick_up = enemy.loot.instantiate()
	pick_up.position = new_position
	call_deferred("add_child",pick_up)

func _on_level_timer_timeout():
	get_tree().paused = true# Replace with function body.
