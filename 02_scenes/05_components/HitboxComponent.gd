extends Area2D

@export var health_component : HealthComponent
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(attack):
	print("Entré en damage {damage}".format({'damage':attack}))
	if health_component:
		print("Entre en if health_component")
		health_component.take_damage(attack)
