extends Node2D

@export var speed: float = 200.0  # Velocidad de movimiento 
var initial_position: Vector2  # posicion original
var initial_rotation: float  # rotacion original

func _ready():
	initial_position = position 
	initial_rotation = rotation  

func _process(delta):
	var direction = Vector2.ZERO

	if Input.is_key_pressed(KEY_SHIFT):  # shift presionado
		if Input.is_key_pressed(KEY_W):
			direction.y -= 1
		if Input.is_key_pressed(KEY_S):
			direction.y += 1
		if Input.is_key_pressed(KEY_A):
			direction.x -= 1
		if Input.is_key_pressed(KEY_D):
			direction.x += 1
		
		position += direction.normalized() * speed * delta
	else:
		# Resetear la posi
		position = position.lerp(initial_position, 5 * delta)
		rotation = lerp_angle(rotation, initial_rotation, 5 * delta)  
