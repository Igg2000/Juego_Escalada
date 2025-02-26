extends Node2D

@export var speed: float = 200.0  # Velocidad de movimiento
@export var x_limit: float = 100.0  # Límite de movimiento en X
@export var return_speed: float = 1.5  # Velocidad de regreso más fluida
@export var hang_distance: float = 150.0  # Cuánto cuelga el brazo

var hombroIzq: Bone2D
var codoIzq: Bone2D
var torso: Bone2D
var manoIzq: Node2D
var distanciaTorsoHombro: float
var initial_position: Vector2  
var initial_rotation: float  
@export var can_move: bool = true   

func _ready():
	initial_position = position  
	initial_rotation = rotation
	hombroIzq = get_parent().get_parent().get_node("Skeleton2D/cintura/torso/hombroIzquierdo")
	torso = get_parent().get_parent().get_node("Skeleton2D/cintura/torso")
	codoIzq = get_parent().get_parent().get_node("Skeleton2D/cintura/torso/hombroIzquierdo/codoIzquierdo")
	manoIzq = get_parent().get_parent().get_node("Skeleton2D/cintura/torso/hombroIzquierdo/codoIzquierdo/manoIzquierda/Marker2D")
	distanciaTorsoHombro = hombroIzq.global_position.y - torso.global_position.y

func _process(delta):
	if !can_move:
		return
	else:
		var direction = Vector2.ZERO

		# Controles con WASD
		if Input.is_key_pressed(KEY_W):
			direction.y -= 1
		elif Input.is_key_pressed(KEY_S):
			direction.y += 1

		if Input.is_key_pressed(KEY_A):
			direction.x -= 1
		elif Input.is_key_pressed(KEY_D):
			direction.x += 1

		# Movimiento restringido con límite en X
		var new_position = position + direction.normalized() * speed * delta
		new_position.x = clamp(new_position.x, initial_position.x - x_limit, initial_position.x + x_limit)  
		position = new_position

		# Regreso progresivo cuando no hay input
		if direction == Vector2.ZERO:
			position = position.lerp(initial_position + Vector2(0, hang_distance), return_speed * delta)
			rotation = lerp_angle(rotation, deg_to_rad(90), return_speed * delta)

func set_can_move(mover):
	can_move = mover

func subirHombro():
	var posicionY = manoIzq.global_position.y  # Guarda la posición Y inicial de la mano
	var diferencia_x = torso.global_position.x - manoIzq.global_position.x  # Diferencia horizontal entre torso y mano
	var diferencia_y = codoIzq.global_position.y - torso.global_position.y  # Diferencia vertical entre codo y torso
	var objetivo_y = torso.global_position.y + diferencia_y  # Altura objetivo del torso
	var velocidad = 0.1  # Velocidad de interpolación

	# Mueve el torso hacia arriba mientras mantienes la distancia X
	while abs(torso.global_position.y - objetivo_y) > 1.0:  # Mientras no esté cerca del objetivo
		# Interpola la posición Y del torso
		torso.global_position.y = lerp(torso.global_position.y, objetivo_y, velocidad)

		# Mantén la posición X del torso a la misma distancia de la mano
		torso.global_position.x = manoIzq.global_position.x + diferencia_x

		# Mantén la mano en su posición Y inicial
		manoIzq.global_position.y = posicionY

		# Espera al siguiente frame
		await get_tree().process_frame

	# Asegura que el torso esté en su posición final
	torso.global_position.y = objetivo_y
	torso.global_position.x = manoIzq.global_position.x + diferencia_x
	manoIzq.global_position.y = posicionY
	print("Subida completada")






	
