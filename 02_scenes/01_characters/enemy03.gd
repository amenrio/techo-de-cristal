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
		#print("Player On Area")

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
		#print("Player Out Of Area")

func _on_shoot_delay_timeout():
	loaded = true

func _process(_delta):
	_aim()
	_check_player_collision()
	
	if playerIsTarget and loaded == true:
		var bullet = ammo.instantiate()
		bullet.position = position
		bullet.velocity = raycast.target_position.normalized()
		get_tree().current_scene.add_child(bullet)
	
#	if playerIsTarget:
#		var direction = (player_instance.global_position - global_position).normalized()
#		castCheck.global_position = global_position
#		castCheck.rotation_degrees = direction.angle()
#
#
#
#		if castCheck.is_colliding():
#			var target = castCheck.get_collider()
#			if target.is_in_group("player"):
#				print("CAST TRUE")
#				if loaded == true and shootDelay == false:
#					print("SHOOT")
#					var bullet = ammo.instantiate()
#					get_tree().current_scene.add_child(bullet)
#					$attack.play()
#					loaded = false
#					shootDelay.set_wait_time(initialTime)
#
#
##	if playerIsTarget:
##		castCheck.target_position = player_instance.global_position - self.global_position
##		queue_redraw()
##		var collidedObject = castCheck.get_collider()
##		print(collidedObject)
#
#
##func _draw():
##	draw_line(Vector2.ZERO, (player_instance.global_position - self.global_position), Color(255, 0 , 0), 3.0, true)
