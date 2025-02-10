extends Node

func _ready():
	var jugador = load("res://scenes/jugador.tscn").instantiate()  # Carga la escena del jugador
	add_child(jugador)  # La agrega como hijo de la escena principal
