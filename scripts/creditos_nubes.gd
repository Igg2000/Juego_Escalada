extends ParallaxBackground

@export var scroll_speed=100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_offset.x -= delta * scroll_speed
	
	if scroll_offset.x <= -8000:
		scroll_offset.x = 0
