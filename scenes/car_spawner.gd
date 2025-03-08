extends Node2D

@export var car_scene: PackedScene  # Asigna la escena del coche en el inspector
@export var spawn_area: Rect2  # Define el área donde aparecerán los coches

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Conectar la señal del Timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
