extends Node2D

@export var weapon_sprite: Texture2D
@export var bulletSpeed: float = 500
@export var bullet_scene: PackedScene
var bullet_number = 3
var bullet_piercing = 1

@onready var level = get_tree().current_scene
@onready var bulletSpawn = $bullet_spawn_point

var positions = {
			1:[Vector2(0,0)],
			2:[Vector2(10,0),Vector2(-10,0)],
			3:[Vector2(0,0),Vector2(0,0),Vector2(0,0)]
}
var angles = {
			1:[Vector2(0,0)],
			2:[Vector2(0,0),Vector2(0,0)],
			3:[Vector2(-12,0),Vector2(0,0),Vector2(12,0)],
			4:[0,25,50,75]}
signal fire

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.texture = weapon_sprite # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _create_bullets(bullet_id):
	var new_angle = angles[bullet_number][bullet_id]
	var new_bullet = bullet_scene.instantiate()
	new_bullet.piercing = bullet_piercing
	new_bullet.bullet_speed = bulletSpeed
	new_bullet.position = bulletSpawn.global_position + positions[bullet_number][bullet_id]
	new_bullet.velocity = bulletSpawn.global_position - global_position + new_angle
	return new_bullet
	
func _process(_delta):
	if Input.is_action_just_pressed('fire'):		
		# Creación de la instancia de la bala
		for bullet in bullet_number:
			print("Hola")
			var bulletInstance = _create_bullets(bullet)
			level.add_child(bulletInstance)

