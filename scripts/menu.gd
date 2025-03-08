extends Control


func _ready():
	pass



func _on_tiempo_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mapa1.tscn")


func _on_altura_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mapa2.tscn")


func _on_creadores_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/creditos.tscn")
