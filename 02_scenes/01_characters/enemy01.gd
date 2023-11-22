extends CharacterBody2D

@export var loot: PackedScene
@export var hit_lag: float = 1.5
@export var _name:String
@onready var player_instance = get_tree().get_first_node_in_group("player")
@onready var health_component = $HealthComponent

var max_speed = 300
var following_player = true
var damage = 10.0

var sprite_string = "res://01_assets/01_sprites/enemy_%s.png"

func _ready():
	var actual_texture = sprite_string % _name
	$sprite.texture = load(actual_texture)
	
func _physics_process(_delta):
	pass
#	if following_player == true:
#		velocity = position.direction_to(player_instance.position) * max_speed
#	move_and_slide()

func _on_hitbox_component_area_entered( area):
	if area.has_method("damage"):
		area.damage(damage)
		following_player = false
		velocity = Vector2.ZERO
		await get_tree().create_timer(hit_lag).timeout
		following_player = true
