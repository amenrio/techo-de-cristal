extends Area2D


@export var damage: float = 10.0
@export var sprite: Texture2D

var bullet_speed: float
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$bullet_sprite.texture = sprite # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_area_entered(area):
	print("area")
	print(area)
	if area.has_method('damage'):
		print("Has method damage")
		area.damage(damage)
	queue_free()

func _process(delta):
	position += velocity.normalized() * delta * bullet_speed
