extends Node2D

@onready var player_instance = get_tree().get_first_node_in_group("player")
@onready var parent = get_parent()
@export var max_speed:float
var following_player = false

func _physics_process(_delta):
	if following_player == true:
		if is_instance_valid(player_instance):
			parent.velocity = parent.position.direction_to(player_instance.position) * max_speed
	parent.move_and_slide()


func _on_detection_area_body_entered(body):
	if body.is_in_group('player'):
		following_player=true
