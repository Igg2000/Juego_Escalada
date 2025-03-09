extends CharacterBody2D

var hay_gravedad = true
var gravedad = 500.0

var mano_izquierda_agarrada = false
var mano_derecha_agarrada = false

var mono_debe_subir = false
var velocidad_movimiento = 150.0
var distancia_a_recorrer = 40.0
var posicion_objetivo

#guardo las posiciones de los ik para que no se muevan junto con el cuerpo
@onready var posManoDerecha = $IK/manoDerechaIK.global_position
@onready var posManoIzquierda = $IK/manoIzquierdaIK.global_position

signal ha_llegado_a_meta	

func _physics_process(delta: float) -> void:
	
	if mono_debe_subir:
		hay_gravedad = false
		
		# Calcular dirección hacia el objetivo cada frame
		var direccion = (posicion_objetivo - global_position).normalized()
		velocity = direccion * velocidad_movimiento
		
		#me muevo mientras reestablezco las posiciones de los ik
		move_and_slide()
		$IK/manoDerechaIK.global_position = posManoDerecha
		$IK/manoIzquierdaIK.global_position = posManoIzquierda
		#si termino de recorrer la distancia paro
		distancia_a_recorrer -= velocity.length() * delta
		if distancia_a_recorrer <= 0:
			velocity = Vector2.ZERO
			distancia_a_recorrer = 40.0
			mono_debe_subir=false
			$IK/manoDerechaIK.global_position = posManoDerecha
			$IK/manoIzquierdaIK.global_position = posManoIzquierda

	if hay_gravedad:
		velocity.y += gravedad * delta
		move_and_slide()


func _on_mano_izquierda_ik_agarrado() -> void:
	print("mano izquierda agarrada")
	
	#velocity = Vector2.UP * velocidad_movimiento
	mano_izquierda_agarrada = true
	mono_debe_subir = true
	posManoIzquierda = $IK/manoIzquierdaIK.global_position
	posManoDerecha = $IK/manoDerechaIK.global_position
	posicion_objetivo = posManoIzquierda
	
func _on_mano_derecha_ik_agarrado() -> void:
	print("mano derecha agarrada")
	
	#velocity = Vector2.UP * velocidad_movimiento
	mano_derecha_agarrada = true
	mono_debe_subir = true
	posManoDerecha = $IK/manoDerechaIK.global_position
	posManoIzquierda = $IK/manoIzquierdaIK.global_position
	posicion_objetivo= posManoDerecha

func _on_mano_derecha_ik_soltado() -> void:
	print("mano derecha soltada")
	velocity = Vector2.ZERO
	mano_derecha_agarrada = false
	if not mano_izquierda_agarrada:
		mono_debe_subir = false
		hay_gravedad = true


func _on_mano_izquierda_ik_soltado() -> void:
	print("mano izquierda soltada")
	velocity = Vector2.ZERO
	mano_izquierda_agarrada = false
	if not mano_derecha_agarrada:
		mono_debe_subir = false
		hay_gravedad = true


func _on_meta_tocada() -> void:
	ha_llegado_a_meta.emit()
