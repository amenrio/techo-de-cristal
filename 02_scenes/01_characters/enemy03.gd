extends "res://02_scenes/01_characters/enemy01.gd"

@onready var shootDelay = $shootDelay
@onready var castCheck = $RayCast2D
@onready var range = $shootRange
@onready var initialTime: float = shootDelay.wait_time

var playerIsTarget: bool = false
var loaded: bool = false

func _on_shoot_rage_area_entered(area):
	if area.has_method("damage"):
		playerIsTarget = true
		shootDelay.start()
		#print("Player On Area")


func _on_shoot_rage_area_exited(area):
	if area.has_method("damage"):
		playerIsTarget = false
		shootDelay.stop()
		shootDelay.set_wait_time(initialTime)
		#print("Player Out Of Area")

func _on_shoot_delay_timeout():
	loaded = true

func _process(delta):
	if playerIsTarget:
		castCheck.look_at(player_instance.global_position - self.global_position)
		if castCheck.is_colliding():
			print("CAST TRUE")
			if castCheck.get_collider() == player_instance:
				if loaded == true:
					print("SHOOT")
					loaded = false
					$attack.play()
					shootDelay.set_wait_time(initialTime)
					

#	if playerIsTarget:
#		castCheck.target_position = player_instance.global_position - self.global_position
#		queue_redraw()
#		var collidedObject = castCheck.get_collider()
#		print(collidedObject)
		

#func _draw():
#	draw_line(Vector2.ZERO, (player_instance.global_position - self.global_position), Color(255, 0 , 0), 3.0, true)
