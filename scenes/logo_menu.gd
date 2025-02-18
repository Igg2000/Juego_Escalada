extends TextureRect

var bandera_logo=0  # Variable entera para el parpadeo del logo solo cuando se inicie el juego la primera vez, no despues de un game over

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#bandera_logo=0
	$LogoTimer.start()
	$TextoLogoLabel.hide()
	hide()
	muestra_logoMenu()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func muestra_logoMenu():
	await $LogoTimer.timeout
	show()
	if bandera_logo<1:
		for i in range(5):  # Repite 5 veces
			hide()  # Oculta el logo
			await get_tree().create_timer(0.2).timeout  # Espera 0.2 segundos
			show()  # Muestra el logo
			await get_tree().create_timer(0.3).timeout  # Espera 0.3 segundos
			
			print(i)  # Imprime 0, 1, 2, 3, 4
			
		await get_tree().create_timer(0.5).timeout  # Espera 0.3 segundos
		$TextoLogoLabel.show()
			
		#Aumentamos la variable bandera_logo para que solo entre al if cuando se inicie el juego
		bandera_logo=5
