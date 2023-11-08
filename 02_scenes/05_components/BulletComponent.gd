extends Area2D
class_name BulletComponent

@export var damage: float = 10.0
@export var sprite: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$bullet_sprite.texture = sprite # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_body_entered(body):
	if body.has_method('take_damage'):
		body.take_damage(damage)
