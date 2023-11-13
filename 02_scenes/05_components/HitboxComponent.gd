extends Area2D

@export var health_component : HealthComponent
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func damage(attack):
	if health_component:
		health_component.take_damage(attack)
