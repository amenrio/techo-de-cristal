extends Area2D

signal pickup

@export var _class:='ingredients'
var _name:String

var _special_drop=false
var _special_type:String

var textures = {
	'chocolate': 'res://01_assets/01_sprites/chocolate.png',
	'citrico': 'res://01_assets/01_sprites/citrico.png',
	'masa': 'res://01_assets/01_sprites/masa.png',
	'health':'res://01_assets/01_sprites/health.png',
	'2shot':'res://01_assets/01_sprites/2shot.png',
	'3shot':'res://01_assets/01_sprites/3shot.png'

}
var special_list = ['2shot','3shot','health']

#func setup(type, pos):
#	$image.texture = load(textures[type])
#	position = pos

func _ready():
	$sprite.texture=load(textures[_name])

func _on_body_entered(body):
	if body.is_in_group('player'):
		emit_signal("pickup")
		body.add_to_inventory({_class:_name})
		queue_free()
