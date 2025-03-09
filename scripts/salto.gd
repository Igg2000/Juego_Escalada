extends Node

@export var player: CharacterBody2D  # Jugador asignado en el editor
@export var jump_force: float = -200.0  # Fuerza del impulso
@export var cooldown: float = 2.0  # Tiempo de espera
@export var indicator: Node2D  # Indicador visual (Sprite2D o TextureRect)
@export var jump_sound: AudioStreamPlayer2D  # Nodo de sonido

var can_use_power: bool = true  # Control del poder

func _ready() -> void:
	update_indicator()  # Asegura que el indicador esté correcto al inicio

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("super_jump") and can_use_power:
		use_power()

func use_power() -> void:
	if player == null:
		print("⚠️ ERROR: No se asignó el jugador en el editor.")
		return

	print("💥 ¡Super salto activado!")
	player.velocity.y = jump_force  # Aplica el impulso en el eje Y
	
	if jump_sound:  
		jump_sound.play()  # 🔊 Reproducir sonido
	
	can_use_power = false  # Desactiva temporalmente
	update_indicator()
	
	await get_tree().create_timer(cooldown).timeout  # Espera el cooldown
	can_use_power = true  # Reactiva el poder
	update_indicator()

func update_indicator() -> void:
	if indicator:
		indicator.visible = can_use_power  # Muestra u oculta el indicador
