extends CharacterBody2D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@export var loot: PackedScene
var speed = 300
var motion = Vector2(0,0)
var go = true
var damage = 10.0

func _physics_process(delta):
	if go == true:
		velocity = position.direction_to(player.position) * speed
	move_and_slide()
	
func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		go=true

func _on_hitbox_component_area_entered(area):
	if area.has_method("damage"):
		area.damage(damage)
		go = false
		velocity = Vector2(0,0)
		await 1
