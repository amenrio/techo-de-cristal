extends Sprite2D

const BEGIN_HEIGHT = 0
const END_HEIGHT = -480

var scroll_speed = 30

func _ready():
	position.y = BEGIN_HEIGHT

func _process(delta):
	position -= Vector2(0, scroll_speed * delta)

	if position.y <= END_HEIGHT:
		position.y -= END_HEIGHT

