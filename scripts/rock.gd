extends Node2D

func _ready():
	# Conectar las señales del Area2D de la roca
	$Roca/Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	$Roca/Area2D.connect("body_exited", Callable(self, "_on_body_exited"))

# Método que se ejecuta cuando un cuerpo entra en el Area2D de la roca
func _on_body_entered(body):
	print("Cuerpo detectado:", body.name)  # Verifica qué cuerpo está entrando
	if body.is_in_group("AntebrazoDc"):
		print("Brazo cerca de la roca")

func _on_body_exited(body):
	print("Cuerpo que sale:", body.name)  # Verifica qué cuerpo está saliendo
	if body.is_in_group("AntebrazoDc"):
		print("Brazo se aleja de la roca")

func _process(delta: float) -> void:
	pass
