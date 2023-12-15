extends Control

var sprite_img: String
var ing_count:int

var textures = {
	'chocolate': 'res://01_assets/01_sprites/ingredientes/chocolate.png',
	'naranja': 'res://01_assets/01_sprites/ingredientes/naranja.png',
	'masa': 'res://01_assets/01_sprites/ingredientes/masa.png'
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.texture = load(textures[sprite_img]) # Replace with function body.
	$count.text = str(ing_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$count.text = str(ing_count)
