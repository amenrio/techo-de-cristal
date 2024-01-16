extends CharacterBody2D

@export var loot: PackedScene
@export var hit_lag: float = 0.5
@export var _name:String
@export var explosionDelay: float = 0.5

@onready var player_instance = get_tree().get_first_node_in_group("player")
@onready var health_component = $HealthComponent
@onready var actRange = $activationRange
@onready var fuse = $timer
@onready var nav_agent = $NavigationAgent2D
@onready var explosion = preload("res://02_scenes/05_others/explosion.tscn")
@onready var animationPlayer = $AnimatedSprite2D

@export var max_speed = 50

var following_player = true
var damage = 15.0
var active = false
var exploding = false
var sprite_string = "res://01_assets/01_sprites/enemy_%s.png"
var isOnView = false

func _ready():
	var actual_texture = sprite_string % _name
	$sprite.texture = load(actual_texture)
	
func _physics_process(_delta):
	#if following_player == true:
	#	velocity = position.direction_to(player_instance.position) * max_speed
	#else:
	#	velocity = position.direction_to(player_instance.position)
	if following_player and isOnView:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * max_speed
		if dir.x < 0:
			animationPlayer.flip_h = true
		elif dir.x >= 0:
			animationPlayer.flip_h = false
		#print(dir.x)
		move_and_slide()

func makepath():
	nav_agent.target_position = player_instance.global_position

func _on_hitbox_component_area_entered(area):
	if area.has_method("damage"):
		following_player = false
		velocity = Vector2.ZERO
		await get_tree().create_timer(hit_lag).timeout
		following_player = true


func _on_activation_range_body_entered(body):
	if body.name == "player":
		following_player = false
		active = true
		fuse.start()


func _on_activation_range_body_exited(body):
	if body.name == "player":
		#print("COME HERE")
		if exploding == false:
			following_player = true
		fuse.stop()
		fuse.set_wait_time(explosionDelay)
		active = false


func _on_timer_timeout():
	following_player = false
	var explosionInstance = explosion.instantiate()
	explosionInstance.position = self.position
	if exploding == false:
		get_parent().add_child(explosionInstance)
		var hitbox = player_instance.get_node("HitboxComponent")
		hitbox.damage(damage * 2)
		animationPlayer.play("explode")
		exploding = true
	queue_free()


func _on_nav_timer_timeout():
	if following_player and isOnView:
		makepath()


func _on_animated_sprite_2d_animation_looped():
	if exploding == true:
		queue_free()


func _on_view_range_body_entered(body):
	if body.is_in_group("player"):
		isOnView = true


func _on_view_range_body_exited(body):
	if body.is_in_group("player"):
		isOnView = false
