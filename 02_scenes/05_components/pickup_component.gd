extends Area2D

signal pickup

@export var _class:='ingredients'
var _name:String
var play_animation:bool = false
@onready var player_instance = get_tree().get_first_node_in_group('player')
var textures = {
	'chocolate': 'res://01_assets/01_sprites/ingredientes/chocolate-Sheet.png',
	'naranja': 'res://01_assets/01_sprites/ingredientes/naranja-Sheet.png',
	'masa': 'res://01_assets/01_sprites/ingredientes/masa-Sheet.png',
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
func _process(delta):
	if play_animation:
		position += position.direction_to(player_instance.position).normalized() * 5
func _on_body_entered(body):
	if body.is_in_group('player'):
		play_animation=true
		emit_signal("pickup")
		body.add_to_inventory({_class:_name})
		await get_tree().create_timer(0.09).timeout
		queue_free()
