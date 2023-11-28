extends CharacterBody2D

@export var loot: PackedScene
@export var hit_lag: float = 1.5
@export var _name:String
@export var explosionDelay: float = 2.5

@onready var player_instance = get_tree().get_first_node_in_group("player")
@onready var health_component = $HealthComponent
@onready var actRange = $activationRange
@onready var fuse = $timer
@onready var nav_agent = $NavigationAgent2D
@onready var explosion = preload("res://02_scenes/05_others/explosion.tscn")

var max_speed = 300
var following_player = true
var damage = 10.0
var active = false

var sprite_string = "res://01_assets/01_sprites/enemy_%s.png"

func _ready():
	var actual_texture = sprite_string % _name
	$sprite.texture = load(actual_texture)
	
func _physics_process(_delta):
	#if following_player == true:
	#	velocity = position.direction_to(player_instance.position) * max_speed
	#else:
	#	velocity = position.direction_to(player_instance.position)
	if following_player == true:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * max_speed
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
		# following_player = false
		active = true
		fuse.start()


func _on_activation_range_body_exited(body):
	if body.name == "player":
		print("COME HERE")
		following_player = true
		fuse.stop()
		fuse.set_wait_time(explosionDelay)
		active = false


func _on_timer_timeout():
	print("BOOM")
	var hitbox = player_instance.get_node("HitboxComponent")
	hitbox.damage(damage * 2)
	var explosionInstance = explosion.instantiate()
	explosionInstance.position = self.position
	get_parent().add_child(explosionInstance)
	get_tree().queue_delete(self)


func _on_nav_timer_timeout():
	makepath()
