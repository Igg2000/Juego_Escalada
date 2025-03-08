extends Node2D

@export var speed: float = 200.0  # Velocidad de movimiento
@export var x_limit: float = 120.0  # Límite de movimiento en X
@export var y_limit: float = 150.0  # Límite de movimiento en Y
@export var return_speed: float = 1.5  # Velocidad de regreso más fluida
@export var hang_distance: float = 160.0  # Cuánto cuelga el brazo

@onready var sprite: AnimatedSprite2D
@onready var AreaMano = Area2D

var initial_position: Vector2  
var initial_rotation: float  
@export var can_move: bool = true   
var can_grab: bool = false


signal agarrado
signal soltado

func _ready():
	initial_position = position  
	initial_rotation = rotation  
	sprite = get_parent().get_parent().get_node("base/AntebrazoIc")
	AreaMano = get_parent().get_parent().get_node("base/AntebrazoIc/Area2D")

func _process(delta):
	
	if Input.is_action_just_released("agarre_izquierdo"):
		sprite.frame = 0 #textura agarrado
		set_can_move(true)
	
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
			
		if Input.is_action_pressed("agarre_izquierdo") && can_grab:
			if sprite.frame == 0:
				sprite.frame = 1 #textura mano abierta
			set_can_move(false)
			
			
		# Movimiento restringido con límite en X
		var new_position = position + direction.normalized() * speed * delta
		new_position.x = clamp(new_position.x, initial_position.x - x_limit, initial_position.x + x_limit)  
		new_position.y = clamp(new_position.y, initial_position.y - y_limit, initial_position.y + y_limit)  
		
		#COMENTAR ESTO SI QUIERES QUE NO SE SALGA DEL AREA2D Y DESCOMENTAR EL IF DE ABAJO
		position = new_position
		
		#ESTO ES PARA QUE NO SE SALGA DEL AREA 2D
		"""
		if AreaMano.overlaps_area($Area2D):  #Accedemos al Area2D dentro de manoIzquierda
			position = new_position
		"""

		#"""
		# Regreso progresivo cuando no hay input
		if direction == Vector2.ZERO:
			position = position.lerp(initial_position + Vector2(0, hang_distance), return_speed * delta)
			rotation = lerp_angle(rotation, deg_to_rad(90), return_speed * delta)
		#"""

func set_can_move(mover):
	
	#si el brazo se podia mover y le digo que se bloquee, emito señal de agarrado
	if can_move and not mover:
		agarrado.emit()
	
	#hago lo contrario
	if not can_move and mover:
		soltado.emit()
		
	can_move = mover
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Rock"):
		can_grab = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Rock"):
		can_grab = false
		
