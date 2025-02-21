extends Node2D

@export var speed: float = 200.0  # Velocidad de movimiento
@export var x_limit: float = 100.0  # Límite de movimiento en X
@export var return_speed: float = 1.5  # Velocidad de regreso más fluida
@export var hang_distance: float = 150.0  # Cuánto cuelga el brazo

var initial_position: Vector2  
var initial_rotation: float  

func _ready():
	initial_position = position  
	initial_rotation = rotation  

func _process(delta):
	var direction = Vector2.ZERO

	# Controles con WASD
	if Input.is_key_pressed(KEY_I):
		direction.y -= 1
	elif Input.is_key_pressed(KEY_K):
		direction.y += 1

	if Input.is_key_pressed(KEY_J):
		direction.x -= 1
	elif Input.is_key_pressed(KEY_L):
		direction.x += 1

	# Movimiento restringido con límite en X
	var new_position = position + direction.normalized() * speed * delta
	new_position.x = clamp(new_position.x, initial_position.x - x_limit, initial_position.x + x_limit)  
	position = new_position

	# Regreso progresivo cuando no hay input
	if direction == Vector2.ZERO:
		position = position.lerp(initial_position + Vector2(0, hang_distance), return_speed * delta)
		rotation = lerp_angle(rotation, deg_to_rad(90), return_speed * delta)
