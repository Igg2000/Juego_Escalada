extends Label

@export var player : Node2D  # Asigna el nodo del jugador desde el editor

var altura_inicial : float = 0.0

func _ready() -> void:
	# Guardamos la altura inicial del jugador cuando comienza el juego
	altura_inicial = player.global_position.y

func _process(delta: float) -> void:
	# Invertimos la resta para que la altura aumente en positivo al subir
	var altura_subida = (altura_inicial - player.global_position.y) / 10  # Ajusta la escala si es necesario
	altura_subida = round(altura_subida)  # Redondeamos para mostrar metros enteros
	
	# Actualizamos el texto del label
	text = "Altura: " + str(altura_subida) + "m"
