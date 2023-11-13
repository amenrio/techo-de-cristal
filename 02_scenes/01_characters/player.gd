extends CharacterBody2D

# Velocidad de movimiento del jugador
@export var max_speed := 500
# Coeficiente de 'rozamiento', utilizado para suavizar los cambios de dirección
@export_range(0,10, 0.1) var drag := 0.15
@onready var weapon = $weapon
@onready var health_component = $HealthComponent
@export var dash_velocity:float=4000
var canDash=true
var isDashing=false
var desired_velocity := Vector2.ZERO

var turn_velocity := Vector2.ZERO
func dash():
	if Input.is_action_pressed('dash') and canDash:
		velocity = velocity.normalized() * dash_velocity
		canDash=false
		isDashing=true
		await get_tree().create_timer(1).timeout
		isDashing=false
		canDash=true
		
func _physics_process(_delta: float) ->  void:
	# Obtenemos la direccion del personaje
	var direction = Input.get_vector('move_left',"move_right",'move_up','move_down')
	# Obtenemos la velocidad maxima del jugador en la direccion del input
	desired_velocity = direction * max_speed
	# Restamos a la velocidad y direccion deseada la velocidad actual del jugador.
	turn_velocity = desired_velocity - velocity
#	print(turn_velocity)
	velocity += turn_velocity * drag
	
	move_and_slide()
	weapon.look_at(get_global_mouse_position())
	dash()
