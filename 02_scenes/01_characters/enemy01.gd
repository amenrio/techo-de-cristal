extends CharacterBody2D

@export var loot: PackedScene
@export var hit_lag: float = 0.4
@export var _name:String
@onready var player_instance = get_tree().get_first_node_in_group("player")
@onready var health_component = $HealthComponent
@onready var nav_agent = $NavigationAgent2D

var max_speed = 200
var following_player = true
var damage = 10.0
signal enemyDeath

var sprite_string = "res://01_assets/01_sprites/enemy_%s.png"

func _ready():
	var actual_texture = sprite_string % _name
	$sprite.texture = load(actual_texture)
	health_component.connect('death',death)
	
func death(_args):
	queue_free()
	
func _physics_process(_delta):
	if following_player == true:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * max_speed
		move_and_slide()
#	if following_player == true:
#		velocity = position.direction_to(player_instance.position) * max_speed
#	move_and_slide()

func makepath():
	nav_agent.target_position = player_instance.global_position

func _on_hitbox_component_area_entered( area):
	if area.has_method("damage") and is_instance_valid(area):
		area.damage(damage)
		following_player = false
		velocity = Vector2.ZERO
		$attack.play()
		await get_tree().create_timer(hit_lag).timeout
		following_player = true


func _on_nav_timer_timeout():
	if following_player == true:
		makepath()
