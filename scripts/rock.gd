extends Node2D

var puede_agarrarse = false
@export var textura_normal_BrazoIz: Texture2D
@export var textura_agarrado_BrazoIz: Texture2D
@export var textura_normal_BrazoDr: Texture2D
@export var textura_agarrado_BrazoDr: Texture2D
var brazo_izquierdo: Sprite2D = null
var brazo_derecho: Sprite2D = null

func _ready():
	if has_node("Area2D"):
		$Area2D.connect("area_entered", Callable(self, "_on_area_entered"))
		$Area2D.connect("area_exited", Callable(self, "_on_area_exited"))
	else:
		printerr("Error: No se encontró Area2D en la roca")

func _on_area_entered(area):
	if area.is_in_group("AntebrazoIc") || area.is_in_group("AntebrazoDc"):
		if area.get_parent().is_in_group("AntebrazoIc"):
			brazo_izquierdo = area.get_parent()
		if area.get_parent().is_in_group("AntebrazoDc"):
			brazo_derecho = area.get_parent()
		puede_agarrarse = true

func _on_area_exited(area):
	if area.is_in_group("AntebrazoIc") || area.is_in_group("AntebrazoDc"):
		puede_agarrarse = false
		resetear_texturas()

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_SHIFT:  # Shift izquierdo para la mano izquierda
			if event.pressed && puede_agarrarse:
				cambiar_textura_agarre(true, "izquierda")
				bloquear_movimiento("izquierda")
			else:
				cambiar_textura_agarre(false, "izquierda")
				desbloquear_movimiento("izquierda")
				
		elif event.keycode == KEY_SPACE:  # Espacio para la mano derecha
			if event.pressed && puede_agarrarse:
				cambiar_textura_agarre(true, "derecha")
				bloquear_movimiento("derecha")
			else:
				cambiar_textura_agarre(false, "derecha")
				desbloquear_movimiento("derecha")

func cambiar_textura_agarre(agarrado: bool, lado: String):
	if lado == "izquierda":
		if brazo_izquierdo:
			brazo_izquierdo.texture = textura_agarrado_BrazoIz if agarrado else textura_normal_BrazoIz
	elif lado == "derecha":
		if brazo_derecho:
			brazo_derecho.texture = textura_agarrado_BrazoDr if agarrado else textura_normal_BrazoDr


func resetear_texturas():
	if brazo_izquierdo: 
		brazo_izquierdo.texture = textura_normal_BrazoIz
	if brazo_derecho: 
		brazo_derecho.texture = textura_normal_BrazoDr

func bloquear_movimiento(lado: String):
	if lado == "izquierda" and brazo_izquierdo:
		var mano_izquierda = brazo_izquierdo.get_parent().get_parent().get_node_or_null("IK/manoIzquierdaIK")
		if mano_izquierda and mano_izquierda.has_method("set_can_move"):
			mano_izquierda.set_can_move(false)
	elif lado == "derecha" and brazo_derecho:
		var mano_derecha = brazo_derecho.get_parent().get_parent().get_node_or_null("IK/manoDerechaIK")
		if mano_derecha and mano_derecha.has_method("set_can_move"):
			mano_derecha.set_can_move(false)

func desbloquear_movimiento(lado: String):
	if lado == "izquierda" and brazo_izquierdo:
		var mano_izquierda = brazo_izquierdo.get_parent().get_parent().get_node_or_null("IK/manoIzquierdaIK")
		if mano_izquierda and mano_izquierda.has_method("set_can_move"):
			mano_izquierda.set_can_move(true)
	elif lado == "derecha" and brazo_derecho:
		var mano_derecha = brazo_derecho.get_parent().get_parent().get_node_or_null("IK/manoDerechaIK")
		if mano_derecha and mano_derecha.has_method("set_can_move"):
			mano_derecha.set_can_move(true)
