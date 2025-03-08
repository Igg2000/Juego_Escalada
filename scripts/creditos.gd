extends RichTextLabel

@export var scroll_speed: float = 50.0  # Velocidad de desplazamiento
@onready var boton_volver: Button

func _ready():
	start_scroll_animation()
	boton_volver = get_parent().get_parent().get_node("VolverAlMenu")

func start_scroll_animation():
	var v_scroll = get_v_scroll_bar()  # Obtén la barra de desplazamiento vertical
	var tween = create_tween()
	
	# Calcula la duración de la animación basada en la longitud del texto
	var text_height = get_content_height()  # Altura total del contenido
	var visible_height = size.y  # Altura visible del RichTextLabel
	var duration = (text_height - visible_height) / scroll_speed
	
	# Anima la barra de desplazamiento
	tween.tween_property(v_scroll, "value", text_height, duration)
	tween.connect("finished", self._on_tween_finished)  # Conecta la señal para reiniciar

func _on_tween_finished():
	# Reinicia la animación
	var v_scroll = get_v_scroll_bar()
	v_scroll.value = 0  # Vuelve al inicio
	start_scroll_animation()  # Inicia la animación de nuevo
	boton_volver.show() #Hace visible el boton
	


func _on_volver_al_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
