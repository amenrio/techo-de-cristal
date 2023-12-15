extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10.0
@onready var health_bar = $health_bar
@onready var parent = get_parent()

signal death

var health: float
# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH
	health_bar.max_value = MAX_HEALTH
	health_bar.value = MAX_HEALTH
	
func _physics_process(_delta):
	if health <=0:
		emit_signal('death',parent)
		parent.queue_free()
		
func take_damage(damage):
	health -= damage
	health_bar.value = health
	

