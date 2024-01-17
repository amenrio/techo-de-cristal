extends "res://02_scenes/01_characters/enemy01.gd"

@onready var shootDelay = $shootDelay
@onready var raycast = $RayCast2D
@onready var initialTime: float = shootDelay.wait_time

var ammo = preload("res://02_scenes/05_components/bullet_component.tscn")

var playerIsTarget: bool = false
var loaded: bool = false

func _ready():
	raycast.add_exception(self)

func _on_shoot_rage_area_entered(area):
	if area.has_method("damage"):
		following_player = false
		playerIsTarget = true
		shootDelay.start()
		##print("Player On Area")

func _aim():
	raycast.target_position = to_local(player_instance.position)

func _check_player_collision():
	if raycast.get_collider() == player_instance:
		playerIsTarget = true

func _on_shoot_rage_area_exited(area):
	if area.has_method("damage"):
		following_player = true
		playerIsTarget = false
		shootDelay.stop()
		shootDelay.set_wait_time(initialTime)
		##print("Player Out Of Area")

func _on_shoot_delay_timeout():
	loaded = true

func _shoot():
	var bullet = ammo.instantiate()
	bullet.set_collision_mask_value(1, true)
	bullet.set_collision_mask_value(2, false)
	bullet.bullet_speed = 400
	bullet.position = position
	bullet.velocity = raycast.target_position.normalized()
	bullet.rotation = randi_range(0, 360)
	get_tree().current_scene.add_child(bullet)
	$attack.play()
	loaded = false
	shootDelay.wait_time = initialTime
	shootDelay.start()
	

func _process(_delta):
	_aim()
	_check_player_collision()
	if playerIsTarget and loaded == true:
		_shoot()
