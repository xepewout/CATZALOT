extends Node

# Reference to the RoomContainer node where rooms will be dynamically loaded
@onready var room_container: Node = $RoomContainer

# Keeps track of the currently loaded room's path
var current_room_path: String = ""

# Function to load a room dynamically
func load_room(room_path: String) -> void:
	# If the requested room is already loaded, do nothing
	if current_room_path == room_path:
		return

	# Unload the current room if any exists
	if room_container.get_child_count() > 0:
		room_container.get_child(0).queue_free()

	# Load the new room scene using @GDScript.Load for performance
	var room_scene: PackedScene = load(room_path)
	var room_instance: Node = room_scene.instantiate() as Node
	room_container.add_child(room_instance)

	# Update the current room path
	current_room_path = room_path

func new_game():
	load_room("res://scenes/test_room.tscn")
	
func _ready() -> void:
	pass
