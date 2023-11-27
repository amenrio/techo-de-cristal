extends CharacterBody2D

@export var loot: PackedScene
@export var hit_lag: float = 1.5
@export var _name:String
@export var explosionDelay: float = 2.5
@onready var player_instance = get_tree().get_first_node_in_group("player")
@onready var health_component = $HealthComponent
@onready var actRange = $activationRange
@onready var fuse = $timer

var max_speed = 300
var following_player = true
var damage = 10.0
var active = false
var playerRef

var sprite_string = "res://01_assets/01_sprites/enemy_%s.png"

func _ready():
	var actual_texture = sprite_string % _name
	$sprite.texture = load(actual_texture)
	
func _physics_process(_delta):
	if following_player == true:
		velocity = position.direction_to(player_instance.position) * max_speed
	else:
		velocity = position.direction_to(player_instance.position)
	move_and_slide()

func _on_hitbox_component_area_entered(area):
	if area.has_method("damage"):
		area.damage(damage)
		following_player = false
		velocity = Vector2.ZERO
		await get_tree().create_timer(hit_lag).timeout
		following_player = true


func _on_activation_range_body_entered(body):
	if body.name == "player":
		playerRef = body
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
	get_tree().queue_delete(self)
