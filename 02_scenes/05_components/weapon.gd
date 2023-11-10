extends Node2D

@export var weapon_sprite: Texture2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.texture = weapon_sprite # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if Input.is_action_pressed('fire'):
		print("Fire")
#		var bullet_instance = $BulletComponent
#		bullet_instance.position = position
#		get_tree().get_root().add_child(bullet_instance)
