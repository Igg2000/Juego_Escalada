extends CharacterBody2D  # O Node2D, dependiendo de tu implementación

@export var gravity: float = 500.0  # Fuerza de gravedad
@export var max_fall_speed: float = 400.0  # Velocidad máxima de caída
var velocity_y: float = 0.0  # Velocidad vertical actual

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():  # Si el jugador no está en el suelo
		velocity_y += gravity * delta  # Aumentar la velocidad vertical
		velocity_y = min(velocity_y, max_fall_speed)  # Limitar la velocidad de caída

	# Mover al jugador en el eje Y
	position.y += velocity_y * delta
