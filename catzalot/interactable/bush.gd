##Author: Yoshi - 10/10/2024
##Class: Bush
##Description:  A bush that is used to get apples upon player
##interaction
extends StaticBody2D

signal  toggle_inventory(external_inventory_owner)
signal drop_slot_data(slot_data: SlotData)
const Slot = preload("res://inventory/slot.tscn")
const Apple = preload("res://item/items/apple.tres")

##Author: Yoshi - 10/10/2024
##Function: player_interact()
##Return: void
##Description: Drop apples upon interact
func player_interact() -> void:
	
	var slot = Slot.instantiate()
	drop_slot_data.emit(slot)
	
