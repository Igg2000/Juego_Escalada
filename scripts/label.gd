extends Label

@export var player : Node2D  # Asigna el nodo del jugador desde el editor

var altura_inicial : float = 0.0
var altura_maxima: int
@export var metros_que_debe_caer_para_perder = 30

signal ha_perdido(alturaMaxima : int)

func _ready() -> void:
	# Guardamos la altura inicial del jugador cuando comienza el juego
	altura_inicial = player.global_position.y

func _process(delta: float) -> void:
	# Invertimos la resta para que la altura aumente en positivo al subir
	var altura_subida = (altura_inicial - player.global_position.y) / 10  # Ajusta la escala si es necesario
	altura_subida = round(altura_subida)  # Redondeamos para mostrar metros enteros

	# Actualizamos el texto del label
	text = "Altura: " + str(altura_subida) + "m"
	
		
	if altura_maxima < altura_subida:
		altura_maxima = altura_subida
	
	if (altura_maxima - altura_subida) >= metros_que_debe_caer_para_perder:
		#print("altura maxima ",altura_maxima," altura subida ", altura_subida, "resultado ")
		ha_perdido.emit(altura_maxima)
		
