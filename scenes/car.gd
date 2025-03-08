extends Node2D

@export var speed: float = 400  # Velocidad del coche
@export var car_textures: Array[Texture2D]  # Lista de texturas disponibles

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if abs(position.x - (-496)) < 50:
		position.x = 1284
		# Cambiar la textura del coche aleatoriamente
		$Sprite2D.texture = car_textures[randi() % car_textures.size()]  # Selecciona aleatoriamente una textura++
	else:
		position.x -= speed * delta  # Mover hacia la derecha
