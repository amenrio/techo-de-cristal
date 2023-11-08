extends Area2D

@export var health_component : HealthComponent
@export var collition_shape : CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.shape = collition_shape # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
