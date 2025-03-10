extends Node2D

var altura_maxima
var record_maximo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_cargar_record()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
"""

func _on_derrota() -> void:
	
	#Establezco los segundos transcurridos
	var tiempo_transcurrido = tiempo_del_nivel - int(timer.time_left)
	$PantallaVictoria/Tiempo_Y.text = "Tiempo: "+str(tiempo_transcurrido)+" segundos"
	record_actual = tiempo_transcurrido
	#Establezco el record del nivel
	$PantallaVictoria/HighScore_n1/Tiempo_n1.text = str(record_maximo)+" segundos"
	
	if record_actual < record_maximo:
		_guardar_record()
		$PantallaVictoria/nuevo_record.show()
"""

func _guardar_record():
	var guardar_partida = FileAccess.open("user://save.recordHigh", FileAccess.WRITE)
	guardar_partida.store_32(int(altura_maxima))
	
func _cargar_record():
	var cargar_partida = FileAccess.open("user://save.recordHigh", FileAccess.READ)
	if cargar_partida != null:
		record_maximo = cargar_partida.get_32()
	else:
		record_maximo = 0
		_guardar_record()
	

# la altura se gestiona en el script del label de la altura,
# cuando cae x metros, se envia esta señal
func _on_label_ha_perdido(a:int) -> void:
	$PantallaGameOver.show()
	altura_maxima = a
	$PantallaGameOver/altura.text = "Altura: "+str(altura_maxima) +" metros"
	$PantallaGameOver/HighScore_n1/metros.text = str(record_maximo) +" metros"
	
	if altura_maxima>record_maximo:
		_guardar_record()
		$PantallaGameOver/nuevo_record.show()
	

func _on_repetir_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mapa1.tscn")


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
