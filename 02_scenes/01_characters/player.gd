extends CharacterBody2D

# Velocidad de movimiento del jugador
@export var max_speed := 500
# Coeficiente de 'rozamiento', utilizado para suavizar los cambios de dirección
@export_range(0.100, 0.250) var drag:= 0.15

@onready var girlfriend_instance = get_tree().get_first_node_in_group('girlfriend')
@onready var animation_tree:AnimationTree = $AnimationTree
@export var dash_velocity: float = 2000
@export var dash_timeout: float = 1.5
@onready var current_level = get_tree().current_scene
@onready var health_component = $HealthComponent
@onready var weapon = $weapon

@onready var hud_comanda = $HUD_canvas_layer/hud_comandas
var direction:Vector2
var comanda_instance = preload("res://02_scenes/02_objects/comanda.tscn")
var completed_comandas: Array
var canDash=true
var isDashing=false

var can_talk_to_girlfriend=false

var desired_velocity := Vector2.ZERO
var turn_velocity := Vector2.ZERO
var objetivos:Array

var inventory:Dictionary = {
	"ingredients":{},
	"modifiers":{},
	"weapons":{}
	}
	
func _ready():
	health_component.connect('death',player_death)
	animation_tree.active = true
	
func player_death(_args):
	get_tree().paused = true
	
var ongoing_comanda:bool = false

func dash():
	if Input.is_action_just_pressed('dash') and canDash:
		velocity = velocity.normalized() * dash_velocity
		canDash=false
		isDashing=true
		await get_tree().create_timer(dash_timeout).timeout
		isDashing=false
		canDash=true
		
func _physics_process(_delta: float) ->  void:
	# Obtenemos la direccion del personaje
	direction = Input.get_vector('move_left',"move_right",'move_up','move_down')
	# Obtenemos la velocidad maxima del jugador en la direccion del input
	desired_velocity = direction * max_speed
	# Restamos a la velocidad y direccion deseada la velocidad actual del jugador.
	turn_velocity = desired_velocity - velocity
#	print(turn_velocity)
	velocity += turn_velocity * drag
	
	move_and_slide()
	# Orientamos el arma hacia el raton
	weapon.look_at(get_global_mouse_position())
	dash()
	talk_to_girlfriend()
	if Input.is_action_just_pressed('complete_comanda'):
		check_completed_comandas()
	check_completed_comandas()
			
func _process(delta):
	print(direction)
	update_animation_tree()
	
func update_animation_tree():
	if (desired_velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false	
		animation_tree["parameters/conditions/is_moving"] = true
	if (desired_velocity != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
	
func check_completed_comandas():
	for comanda in objetivos:
		if comanda.timed_out:
			objetivos.erase(comanda)
			hud_comanda.remove_child(comanda)
			continue
			
		if not comanda.is_completed:
			for ingredient in inventory["ingredients"]:
				if inventory["ingredients"][ingredient] < 1:
					continue
				if ingredient in comanda.ingredients:
					if not comanda.completed_ingredients.has(ingredient):
							comanda.completed_ingredients[ingredient]=0
					if comanda.ingredients[ingredient] > comanda.completed_ingredients[ingredient]:
						inventory["ingredients"][ingredient] -= 1
						print(inventory["ingredients"][ingredient])
						comanda.ingredients[ingredient]
						comanda.completed_ingredients[ingredient] +=1
						continue
		if comanda.is_completed:
			objetivos.erase(comanda)
			hud_comanda.remove_child(comanda)
			completed_comandas.append(comanda)
			continue


func add_to_inventory(pickup_object):
	"""Function that recieves the object that is being picked up
	It's structure is {pickup_class:pickup_name}, ej: {"ingredients":"manzana"}
	
	TODO:
		instead of pickup_name, pass pickup_object_reference so we can use variables and more complex methods
	"""
	for pickup_class in pickup_object:
		var pickup_name = pickup_object[pickup_class]
		if not pickup_name in inventory[pickup_class]:
			inventory[pickup_class].merge({pickup_name:0})
		inventory[pickup_class][pickup_name]+=1

	
func _on_interaction_zone_area_entered(area):
	if area.is_in_group('girlfriend'):
		can_talk_to_girlfriend = true
		# Replace with function body.

func talk_to_girlfriend():
	if Input.is_action_just_pressed("interact") and can_talk_to_girlfriend:
		if len(objetivos) == 0:
			for child in hud_comanda.get_children():
				hud_comanda.remove_child(child)
			var _objectives = girlfriend_instance.get_new_comandas(3)
			for comanda in _objectives:
				var comanda_activa = comanda_instance.instantiate()
				comanda_activa.init(comanda)
				hud_comanda.add_child(comanda_activa)
				hud_comanda.add_spacer(false)
				objetivos.append(comanda_activa)
				print("Añadida comanda")
#		check_completed_comandas()
	
func _on_interaction_zone_area_exited(area):
	if area.is_in_group('girlfriend'):
		can_talk_to_girlfriend = false # Replace with function body.
