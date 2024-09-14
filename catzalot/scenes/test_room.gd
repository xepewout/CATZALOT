extends Node

@export var mob_mouse_scene: PackedScene

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_mouse_scene.instantiate()

	# Choose a random location on Path2D.
	var mouse_spawn_location = $MousePath/MouseSpawnLocation
	mouse_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mouse_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mouse_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
func _ready():
	$MobTimer.start()
	print("hi")
