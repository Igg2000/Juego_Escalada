extends Node2D

func _ready():
	print("Script de Rock iniciado")  # Verifica que el script se esté ejecutando
	if has_node("Area2D"):
		print("Area2D encontrado en Rock")  # Verifica que el Area2D exista
		$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
		$Area2D.connect("body_exited", Callable(self, "_on_body_exited"))
	else:
		print("Error: No se encontró el nodo Area2D en Rock")  # Mensaje de error

func _on_body_entered(body):
	print("Cuerpo detectado:", body.name)  # Verifica qué cuerpo está entrando
	if body.is_in_group("AntebrazoDc"):
		print("Brazo cerca de la roca")
	else:
		print("Otro cuerpo detectado:", body.name)  # Verifica si otros cuerpos están entrando

func _on_body_exited(body):
	print("Cuerpo que sale:", body.name)  # Verifica qué cuerpo está saliendo
	if body.is_in_group("AntebrazoDc"):
		print("Brazo se aleja de la roca")
	else:
		print("Otro cuerpo sale:", body.name)  # Verifica si otros cuerpos están saliendo
