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
	#Verificamos si el área pertenece a los brazos
	if area.is_in_group("AntebrazoIc") || area.is_in_group("AntebrazoDc"):
		#Obtenemos la jerarquía completa: Area2D -> Antebrazo -> base -> Jugador
		if area.get_parent().is_in_group("AntebrazoIc"):
			brazo_izquierdo = area.get_parent()
		if area.get_parent().is_in_group("AntebrazoDc"):
			brazo_derecho = area.get_parent()
		
		puede_agarrarse = true
		#print("Brazo detectado cerca de la roca")

func _on_area_exited(area):
	if area.is_in_group("AntebrazoIc") || area.is_in_group("AntebrazoDc"):
		puede_agarrarse = false
		resetear_texturas()
		#print("Brazo se aleja de la roca")

func _input(event):
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_SHIFT:
			if puede_agarrarse:
				cambiar_textura_agarre(true)
			else:
				cambiar_textura_agarre(false)

func cambiar_textura_agarre(agarrado: bool):
	if agarrado:
		if brazo_izquierdo: brazo_izquierdo.texture = textura_agarrado_BrazoIz
		if brazo_derecho: brazo_derecho.texture = textura_agarrado_BrazoDr
		print("¡Agarrándose a la roca!")
	else:
		resetear_texturas()
		print("Soltando la roca")

func resetear_texturas():
	if brazo_izquierdo: 
		brazo_izquierdo.texture = textura_normal_BrazoIz
	if brazo_derecho: 
		brazo_derecho.texture = textura_normal_BrazoDr
