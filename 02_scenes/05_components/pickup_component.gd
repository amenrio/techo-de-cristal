extends Area2D

signal pickup

var textures = {
	'choclate': 'res://01_assets/01_sprites/choclate.png',
	'citrico': 'res://01_assets/01_sprites/citrico.png',
	'masa': 'res://01_assets/01_sprites/masa.png'
}
		
func setup(type, pos):
	$image.texture = load(textures[type])
	position = pos
	
func _on_body_entered(body):
	emit_signal("pickup")
	queue_free()
