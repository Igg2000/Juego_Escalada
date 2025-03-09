extends Node2D

@onready var timer: Timer = $Timer
@export var tiempo_del_nivel: int = 60
var record_actual: int  = 0
var record_maximo: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(tiempo_del_nivel)
	_cargar_record()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_jugador_ha_llegado_a_meta() -> void:
	#Muestro la pantalla de victoria
	$PantallaVictoria.show()
	#Establezco los segundos transcurridos
	var tiempo_transcurrido = tiempo_del_nivel - int(timer.time_left)
	$PantallaVictoria/Tiempo_Y.text = "Tiempo: "+str(tiempo_transcurrido)+" segundos"
	record_actual = tiempo_transcurrido
	#Establezco el record del nivel
	$PantallaVictoria/HighScore_n1/Tiempo_n1.text = str(record_maximo)+" segundos"
	
	if record_actual >= record_maximo:
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
		record_actual = 0
		_guardar_record()
	
	
	

func _on_repetir_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mapa1.tscn")


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
