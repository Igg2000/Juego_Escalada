extends Area2D

@export var rock_scene: PackedScene  # Drag and drop your Rock scene here in the Inspector
@export var number_of_rocks: int = 5  # Set how many rocks you want from the Editor
@export var min_distance: float = 50.0  # Minimum allowed distance between rocks

var spawned_positions = []  # Stores positions of spawned rocks to avoid overlap

func _ready():
	if rock_scene == null:
		print("Rock scene is not assigned!")
	else:
		spawn_rocks()

func spawn_rocks():
	var collision_shape = $CollisionShape2D

	if collision_shape.shape == null:
		print("CollisionShape2D does not have a valid shape!")
		return

	var area_extents = collision_shape.shape.extents  # Collider boundaries

	for i in range(number_of_rocks):
		var spawn_pos = get_valid_spawn_position(area_extents)
		
		if spawn_pos != Vector2.INF:  # Check if a valid position was found
			var rock_instance = rock_scene.instantiate()
			rock_instance.position = spawn_pos
			add_child(rock_instance)
			spawned_positions.append(spawn_pos)
			print("Rock spawned at: ", spawn_pos)

func get_valid_spawn_position(area_extents: Vector2) -> Vector2:
	var attempts = 10  # Max attempts to find a valid spot

	for i in range(attempts):
		var spawn_x = randf_range(global_position.x - area_extents.x, global_position.x + area_extents.x)
		var spawn_y = randf_range(global_position.y - area_extents.y, global_position.y + area_extents.y)
		var candidate_pos = Vector2(spawn_x, spawn_y)

		if is_far_enough(candidate_pos):
			return candidate_pos  # Valid position found

	print("Could not find a valid spawn position after multiple attempts.")
	return Vector2.INF  # Return invalid position if no valid one is found

func is_far_enough(candidate_pos: Vector2) -> bool:
	for existing_pos in spawned_positions:
		if candidate_pos.distance_to(existing_pos) < min_distance:
			return false  # Too close to an existing rock
	return true  # Position is valid
