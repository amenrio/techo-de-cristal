extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10.0
@onready var health_bar = $health_bar
@onready var parent = get_parent()
@onready var sprite = get_parent().get_node("sprite")

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
	if sprite:
		sprite.modulate = Color(1, 0, 0)
		$AudioHit.play()
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 0.2
		timer.one_shot = true
		timer.connect("timeout", _on_timer_timeout)
		timer.start()

func _on_timer_timeout() -> void:
	sprite.modulate = Color(1, 1, 1)

func add_health(value):
	$AudioHeal.play()
	if health + value > MAX_HEALTH:
		health = MAX_HEALTH
	else:
		health += value
	health_bar.value = health
