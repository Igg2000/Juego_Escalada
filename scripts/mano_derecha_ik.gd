extends Node2D

@export var speed: float = 200.0  # Velocidad de movimiento de la mano
var initial_position: Vector2  # posicion original
var initial_rotation: float  #rotacion original

func _ready():
	initial_position = position  
	initial_rotation = rotation  

func _process(delta):
	var direction = Vector2.ZERO

	if Input.is_key_pressed(KEY_SHIFT):  # Si Shift 
		if Input.is_key_pressed(KEY_UP):
			direction.y -= 1
		if Input.is_key_pressed(KEY_DOWN):
			direction.y += 1
		if Input.is_key_pressed(KEY_LEFT):
			direction.x -= 1
		if Input.is_key_pressed(KEY_RIGHT):
			direction.x += 1
		
		position += direction.normalized() * speed * delta
	else:
		# Reset a 90 grados
		position = position.lerp(initial_position, 5 * delta)
		rotation = lerp_angle(rotation, initial_rotation, 5 * delta) 
