extends Area2D

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData
const Slot = preload("res://inventory/slot.tscn")

var time_accumulator = 0.0
@export var follow_delay = 1
@export var speed = 25
var player_pos: Vector2
var lerpys: Vector2
var cook_time = 0.0
var cook: bool


func _ready():
	cook = false
	pass

func _get_player_pos(playerPosition: Vector2):
	player_pos = playerPosition
	print("player_pos set to", player_pos)
	
func _process(delta):
	
	if cook:
		cook_time += delta
	if !cook:
		cook_time = 0.0
		
	time_accumulator+=delta
	if time_accumulator > 1:
		lerpys = lerp(global_position,player_pos - Vector2(30,0),delta)
		$AnimatedSprite2D.play("walk")
		if lerpys == global_position:
			time_accumulator = 0
			$AnimatedSprite2D.play("idle")	
	else: 
		$AnimatedSprite2D.play("idle")
	global_position = lerpys
	
func player_interact() -> void:
	toggle_inventory.emit(self)
	cook = !cook
	print (cook, cook_time)
	
func player_command() -> void:
	
	var slot = Slot.instantiate()
	slot = PlayerManager.hand_slot
	var index = 0
	# Stops the loop once an empty slot is found
	for i in range(len(inventory_data.slot_datas)):
		if not inventory_data.slot_datas[i]:
			index = i
			break 
	#gets rid of two
	inventory_data.drop_single_slot_data(slot, index)
	if(slot.quantity == 0):
		PlayerManager.clear_hand_slot()
	PlayerManager.update_hand()
	inventory_data.inventory_updated.emit(self)
	print("command")
