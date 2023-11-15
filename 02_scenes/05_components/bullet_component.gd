extends Area2D


@export var damage: float = 10.0
@export var sprite: Texture2D
var piercing: int = 0


var velocity = Vector2.ZERO
var bullet_speed: float = 500
var life_span:float = 0.5 # Effectively -> bullet_range


# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.texture = sprite # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_area_entered(area):
	if area.has_method('damage'):
		area.damage(damage)
		piercing -= 1

func _process(delta):
	position += velocity.normalized() * delta * bullet_speed
	life_span -= delta
	if piercing < 0 or life_span <=0:
		queue_free()
	
