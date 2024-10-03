extends Node

var player
var hand_slot: SlotData
const Hand = preload("res://item/hand/hand.tscn")
func use_slot_data(slot_data: SlotData) -> void:
	slot_data.item_data.use(player)

func get_global_position() -> Vector2:
	return player.global_position
	
func update_hand_slot(slot_data: SlotData) -> void:
	if hand_slot == slot_data:
		print("1")
		return

	# Unload the current room if any exists
	if player.get_child_count() > 4:
		print("2")
		player.get_child(4).queue_free()

	var hand = Hand.instantiate() as Node
	hand.slot_data = slot_data
	player.add_child(hand)
	#var hand_instance: Node = slot_data.instantiate() as Node
	#player.add_child(pick_up)

	# Update the current room path
	hand_slot = slot_data
	print(hand_slot.item_data.name)
	#player.add_child(hand_slot)
