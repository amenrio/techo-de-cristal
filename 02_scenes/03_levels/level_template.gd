extends Node2D

# Called when the node enters the scene tree for the first time.
@export var time_limit: float = 10
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	var player = $player
	var player_start = $player_start
	player.position = player_start.position


func _on_level_timer_timeout():
	get_tree().paused = true# Replace with function body.
