extends Node2D

@export var weapon_sprite: Texture2D
@export var bullet_scene: PackedScene

var bullet_number = 1
var bullet_piercing = 0

@onready var level = get_tree().current_scene
@onready var bulletSpawn = $bullet_spawn_point
@onready var shot_delay = $show_delay

var positions = {
			1:[Vector2(0,0)],
			2:[Vector2(10,0),Vector2(-10,0)],
			3:[Vector2(0,0),Vector2(0,0),Vector2(0,0)]
}
var angles = {
			1:[Vector2(0,0)],
			2:[Vector2(0,0),Vector2(0,0)],
			3:[Vector2(-12,0),Vector2(0,0),Vector2(12,0)]
			}
signal fire
var can_shoot = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.texture = weapon_sprite # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _create_bullet(bullet_idx):	
	var new_angle = angles[bullet_number][bullet_idx]
	var new_bullet = bullet_scene.instantiate()
	new_bullet.piercing = bullet_piercing
	new_bullet.position = bulletSpawn.global_position + positions[bullet_number][bullet_idx]
	new_bullet.velocity = (bulletSpawn.global_position - global_position) + new_angle
	can_shoot=false
	return new_bullet
	
func _process(_delta):
	if Input.is_action_pressed('fire') and can_shoot:		
		# Creación de la instancia de la bala
		for bullet_idx in bullet_number:
			var bulletInstance = _create_bullet(bullet_idx)
			level.add_child(bulletInstance)
			$ShotAudio.play()


func _on_show_delay_timeout():
	can_shoot=true
