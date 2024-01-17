extends CharacterBody2D

@export var loot: PackedScene
@export var hit_lag: float = 0.4
@export var _name:String
@onready var player_instance = get_tree().get_first_node_in_group("player")
@onready var health_component = $HealthComponent
@onready var nav_agent = $NavigationAgent2D
@onready var viewrage = $viewRange
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var explosion = preload("res://02_scenes/05_others/enemyExplosion.tscn")

var max_speed = 200
var following_player = true
var isOnView = false
var damage = 15.0
signal enemyDeath

var sprite_string = "res://01_assets/01_sprites/enemy_%s.png"

func _ready():
	var actual_texture = sprite_string % _name
	$sprite.texture = load(actual_texture)
	health_component.connect('death',death)
	
func death(_args):
#	var explInstance = explosion.instantiate()
#	get_parent().add_child(explInstance)
	queue_free()
	
func stateMachine(currentState: String) -> void:
	match currentState:
		"idle":
			if animated_sprite_2d.animation == "default":
				animated_sprite_2d.play("idle")
		"default":
			if animated_sprite_2d.animation == "idle":
				animated_sprite_2d.play("default")
		

func _physics_process(_delta):
	if following_player == true and isOnView == true:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * max_speed
		if dir.x < 0:
			animated_sprite_2d.flip_h = true
		if dir.x >= 0:
			animated_sprite_2d.flip_h = false
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
	if following_player == true and isOnView == true:
		makepath()
		stateMachine("default")
	else:
		stateMachine("idle")


func _on_view_range_body_entered(body):
	if body.is_in_group("player"):
		isOnView = true
		#print(isOnView)


func _on_view_range_body_exited(body):
	if body.is_in_group("player"):
		isOnView = false
