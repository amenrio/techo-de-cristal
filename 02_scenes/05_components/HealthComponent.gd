extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10.0

signal death

var health: float
# Called when the node enters the scene tree for the first time.

func _ready():
	health = MAX_HEALTH # Replace with function body.
	
func take_damage(damage):
	print("Entre en take damage")
	health -= damage
	if health <= 0:
		emit_signal("death")
		
