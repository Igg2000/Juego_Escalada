extends Node2D

@onready var timer: Timer = $Timer
@onready var reloj: TextureProgressBar = $Timer/CanvasLayer/RelojDeArena
@onready var tiempo: RichTextLabel = $Timer/CanvasLayer/tiempo
@export var tiempo_del_nivel: int = 60
var record_actual: int  = 0
var record_maximo: int

var imagenReloj: int = 1 # 1 verde, 2 amarillo 3 rojo
@onready var textura_reloj_1 = load("res://assets/sandwatch/reloj_de_arena1.png")
@onready var textura_reloj_2 = load("res://assets/sandwatch/reloj_de_arena2.png")
@onready var textura_reloj_3 = load("res://assets/sandwatch/reloj_de_arena3.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(tiempo_del_nivel)
	_cargar_record()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#contador
	tiempo.text = str(int(timer.time_left))
	if timer.time_left < 11:
		tiempo.text = "[color=red]"+str(int(timer.time_left))+"[/color]"
	else:
		tiempo.text = str(int(timer.time_left))
		
	#reloj de arena
	reloj.value = int(timer.time_left)
	
	relojCambiaDeColor()
	


func _on_jugador_ha_llegado_a_meta() -> void:
	timer.paused = true
	#Muestro la pantalla de victoria
	$PantallaVictoria.show()
	#Establezco los segundos transcurridos
	var tiempo_transcurrido = tiempo_del_nivel - int(timer.time_left)
	$PantallaVictoria/Tiempo_Y.text = "Tiempo: "+str(tiempo_transcurrido)+" segundos"
	record_actual = tiempo_transcurrido
	#Establezco el record del nivel
	$PantallaVictoria/HighScore_n1/Tiempo_n1.text = str(record_maximo)+" segundos"
	
	if record_actual < record_maximo:
		_guardar_record()
		$PantallaVictoria/nuevo_record.show()
	
func _guardar_record():
	var guardar_partida = FileAccess.open("user://save.recordTime", FileAccess.WRITE)
	guardar_partida.store_32(record_actual)
	
func _cargar_record():
	var cargar_partida = FileAccess.open("user://save.recordTime", FileAccess.READ)
	if cargar_partida != null:
		record_maximo = cargar_partida.get_32()
	else:
		record_maximo = int(tiempo_del_nivel)
		_guardar_record()
	
	

func _on_repetir_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mapa1.tscn")


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_timer_timeout() -> void:
	$PantallaDerrota.show()
	
func relojCambiaDeColor():
	
	if reloj.value > tiempo_del_nivel / 2: #si queda mas de la mitad el reloj es verde
		if imagenReloj == 1:
			return
		else:
			reloj.texture_progress = textura_reloj_1
			imagenReloj=1
	elif reloj.value <= tiempo_del_nivel / 4: # si queda un cuarto o menos es rojo
		if imagenReloj == 3:
			return
		else:
			reloj.texture_progress = textura_reloj_3
			imagenReloj = 3
	else: #si llega aqui esta por debajo de la mitad y por encima del cuarto, y estaría en ambar
		if imagenReloj == 2:
			return;
		else:
			reloj.texture_progress = textura_reloj_2
			imagenReloj=2


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
