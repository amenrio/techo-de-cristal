extends Node2D

@export var weapon_sprite: Texture2D
@export var bulletSpeed: float = 200
@onready var level = get_parent().get_node("/root/levelAlpha")
@onready var bulletSpawn = get_parent().get_node("/root/levelAlpha/player/weapon/bullet_spawn_point")
@onready var bullet_scene = load("res://02_scenes/05_components/bullet_component.tscn")
signal fire

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.texture = weapon_sprite # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	if Input.is_action_just_pressed('fire'):
		print("Fire")
		
		# Creación de la instancia de la bala
		var bulletInstance = bullet_scene.instantiate()
		
		# Set de las variables de la bala
		bulletInstance.bullet_speed = bulletSpeed
		bulletInstance.position = bulletSpawn.global_position
		bulletInstance.velocity = bulletSpawn.global_position - global_position
		# print("position: ", position)
		# print("bullet spawn global position: ", bulletSpawn.global_position)
		
		# Spawn de la bala
		level.add_child(bulletInstance)
		# emit_signal("fire")
#		var bullet_instance = $BulletComponent
#		bullet_instance.position = position
#		get_tree().get_root().add_child(bullet_instance)
