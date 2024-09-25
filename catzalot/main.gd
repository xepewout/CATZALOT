extends Node

const PickUp = preload("res://item/pick_up/pick_up.tscn")

@onready var player = $Player
@onready var inventory_interface: Control = $HUD/InventoryInterface
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
	load_room("res://rooms/test_room.tscn")
	
			
func _ready() -> void:
	
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func toggle_inventory_interface(external_inventory_owner = null) -> void:
	inventory_interface.visible = not inventory_interface.visible
	
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()


func _on_inventory_interface_drop_slot_data(slot_data):
	var pick_up = PickUp.instantiate()
	pick_up.slot_data = slot_data
	pick_up.position = player.get_drop_position()
	add_child(pick_up)
