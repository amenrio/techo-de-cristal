extends "res://02_scenes/01_characters/enemy01.gd"

@onready var shootDelay = $shootDelay
@onready var castCheck = $RayCast2D
@onready var range = $shootRage

#var bool: playerIsTarget = false
#
#func _on_shoot_rage_area_entered(area):
#	if area.has_method("damage"):
#		print("Player On Area")
#		while playerIsTarget == true:
#			castCheck.target_position(player_instance.global_position)
#
#		pass
