extends Control


func _ready():
	pass



func _on_tiempo_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mapa1.tscn")


func _on_altura_button_pressed() -> void:
	print("Este boton deberia llevar al segundo nivel")


func _on_creadores_button_pressed() -> void:
	print("Este boton deberia llevar a los creditos")
