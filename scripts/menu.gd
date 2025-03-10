extends Control

@onready var pajarosMarrones: Node2D = $Pajaros

func _ready():
	pass
	
func _process(delta: float) -> void:
	pajarosMarrones.global_position.x +=1



func _on_tiempo_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mapa1.tscn")


func _on_altura_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mapa2.tscn")


func _on_creadores_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/creditos.tscn")


func _on_salir_button_pressed() -> void:
	get_tree().quit()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pajarosMarrones.global_position.x = -430
