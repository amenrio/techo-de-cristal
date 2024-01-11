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

@onready var hud_comanda = $GUI/interfaces/comandas

var inventoryIngredient_instance = preload('res://02_scenes/04_screens/inventory_ingredient.tscn')
@onready var inventory_gui = $GUI/interfaces/inventoryMargin/inventory
var inventory_gui_count: Dictionary
var direction:Vector2
var comanda_instance = preload("res://02_scenes/04_screens/comanda.tscn")
var completed_comandas: Array
var canDash=true
var isDashing=false
var isWalking=false

var can_talk_to_girlfriend=false

var desired_velocity := Vector2.ZERO
var turn_velocity := Vector2.ZERO
var objetivos:Array = []

var inventory:Dictionary = {
	"ingredients":{},
	"modifiers":{},
	"weapons":{}
	}
	
var ongoing_comanda:bool = false
func _ready():
	health_component.connect('death',player_death)
	animation_tree.active = true
	
func player_death(_args):
	$deathAudio.play()
	Autoload.load_result_screen(0)

func dash():
	if Input.is_action_just_pressed('dash') and canDash:
		velocity = velocity.normalized() * dash_velocity
		canDash=false
		isDashing=true
		$DashAudio.play()
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
	
	# Orientamos el arma hacia el raton
	weapon.look_at(get_global_mouse_position())
	dash()
	talk_to_girlfriend()
	for comanda in objetivos:
		check_completed_comandas(comanda)
	
	move_and_slide()

func _process(_delta):
	update_animation_tree()
	
func update_animation_tree():
	if (desired_velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
		if (isWalking == true):
			$walkingAudio.stop()
			isWalking = false
	else:
		animation_tree["parameters/conditions/idle"] = false	
		animation_tree["parameters/conditions/is_moving"] = true
		if (isWalking == false):
			$walkingAudio.play()
			isWalking = true
	if (desired_velocity != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
	
func check_completed_comandas(comanda):
	if comanda.timed_out:
		objetivos.erase(comanda)
#			comanda.animation_player.play("exit")
		comanda.animation_player.play("exit")
		await get_tree().create_timer(0.4).timeout
		hud_comanda.remove_child(comanda)
		$comandaTimeOut.play()
		return
		
	for ingredient in comanda.ingredients:
		if ingredient not in inventory["ingredients"]:
			return
		if inventory["ingredients"][ingredient] < 1:
			return
		if inventory["ingredients"][ingredient] >= comanda.ingredients[ingredient]:
			comanda.completed_ingredients[ingredient] = comanda.ingredients[ingredient]
	
	if comanda.f_is_completed():
		subtract_comanda_ingredients_from_gui_inventory(comanda)
		objetivos.erase(comanda)
		comanda.animation_player.play("exit")
		await get_tree().create_timer(0.4).timeout
		hud_comanda.remove_child(comanda)
		completed_comandas.append(comanda)
		Autoload.totalComandas = completed_comandas.size()
		Autoload.globalScore += (100 + get_parent().get_node("level_timer").time_left as int)
		$comandaCompletada.play()
	else:
		comanda.completed_ingredients = {}
#	for ingredient in inventory["ingredients"]:
#		if inventory["ingredients"][ingredient] < 1:
#			continue
#		if ingredient in comanda.ingredients:
#			if not comanda.completed_ingredients.has(ingredient):
#					comanda.completed_ingredients[ingredient] = 0
#			if comanda.ingredients[ingredient] > comanda.completed_ingredients[ingredient]:
#				inventory["ingredients"][ingredient] -= 1
##						inventory_gui_count[ingredient].ing_count += 1
#				comanda.completed_ingredients[ingredient] += 1
#				continue

			
func subtract_comanda_ingredients_from_gui_inventory(comanda):
	for ing in comanda.ingredients:
		inventory_gui_count[ing].ing_count -= comanda.ingredients[ing]
		inventory["ingredients"][ing]-=comanda.ingredients[ing]

func add_to_inventory(pickup_object):
	"""Function that recieves the object that is being picked up
	It's structure is {pickup_class:pickup_name}, ej: {"ingredients":"manzana"}
	
	TODO:
		instead of pickup_name, pass pickup_object_reference so we can use variables and more complex methods
	"""
	for pickup_class in pickup_object:
		var pickup_name = pickup_object[pickup_class]			
		if pickup_class == 'modifiers':
			if pickup_name == 'health':
				health_component.add_health(20)
			elif pickup_name == 'piercing':
				if weapon.bullet_piercing < 3:
					weapon.bullet_piercing += 1
				else:
					health_component.add_health(20)
			elif pickup_name == 'extra_shot':
				if weapon.bullet_number < 3:
					weapon.bullet_number += 1
				else:
					health_component.add_health(20)
		else:
			if not pickup_name in inventory[pickup_class]:
				inventory[pickup_class].merge({pickup_name:0})
				var inventory_ingredient = inventoryIngredient_instance.instantiate()
				inventory_ingredient.sprite_img = pickup_name
				inventory_gui_count[pickup_name] = inventory_ingredient
				inventory_gui.ingredient_slots.add_child(inventory_ingredient)
			inventory[pickup_class][pickup_name] += 1
			inventory_gui_count[pickup_name].ing_count += 1
	$pickUpAudio.play()
	Autoload.totalIngredients += 1

	
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
				health_component.add_health(20)
				await get_tree().create_timer(0.1).timeout
				var comanda_activa = comanda_instance.instantiate()
				comanda_activa.init(comanda)
				hud_comanda.add_child(comanda_activa)
#				comanda_activa.animation_player.play("init")
				objetivos.append(comanda_activa)
			await girlfriend_instance.show_dialog()
func _on_interaction_zone_area_exited(area):
	if area.is_in_group('girlfriend'):
		can_talk_to_girlfriend = false # Replace with function body.
