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

@onready var timer: Timer
@onready var timer_cd: Timer
var en_cooldown = false
@onready var rueda_stamina: TextureProgressBar

signal agarrado
signal soltado

func _ready():
	initial_position = position  
	initial_rotation = rotation  
	sprite = get_parent().get_parent().get_node("base/AntebrazoIc")
	AreaMano = get_parent().get_parent().get_node("base/AntebrazoIc/Area2D")
	timer = get_parent().get_parent().get_node("base/AntebrazoIc/TiempoColgado")
	timer_cd = get_parent().get_parent().get_node("base/AntebrazoIc/Cooldown")
	rueda_stamina = get_parent().get_parent().get_node("base/AntebrazoIc/RuedaStamina")
	
func _process(delta):
	#print(timer.time_left)
	
	if Input.is_action_just_released("agarre_izquierdo"):
		sprite.frame = 0 #textura abierta
		set_can_move(true)
	
	#Esta es la logica para la rueda de stamina del mono
	if timer.time_left > 0 and !can_move:
		timer.time_left
		rueda_stamina.value = timer.time_left
		rueda_stamina.show()
	else:
		rueda_stamina.hide()
	
	if !can_move or en_cooldown:
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
				sprite.frame = 1 #textura mano cerrada
			set_can_move(false)
			
			
			
		# Movimiento restringido con límite en X
		var new_position = position + direction.normalized() * speed * delta
		new_position.x = clamp(new_position.x, initial_position.x - x_limit, initial_position.x + x_limit)  
		new_position.y = clamp(new_position.y, initial_position.y - y_limit, initial_position.y + y_limit)  
		position = new_position
		
		# Regreso progresivo cuando no hay input
		if direction == Vector2.ZERO:
			position = position.lerp(initial_position + Vector2(0, hang_distance), return_speed * delta)
			rotation = lerp_angle(rotation, deg_to_rad(90), return_speed * delta)

func set_can_move(mover):
	
	#si el brazo se podia mover y le digo que se bloquee, emito señal de agarrado
	if can_move and not mover:
		agarrado.emit()
		timer.start()
	
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
		


func _on_timer_timeout() -> void:
	sprite.frame = 0 #textura abierta
	set_can_move(true)
	timer_cd.start()
	en_cooldown = true
	can_grab= false
	


func _on_cooldown_timeout() -> void:
	en_cooldown = false
