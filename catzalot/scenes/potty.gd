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
	inventory_data.slot_datas[1].set_slot_data(PlayerManager.hand_slot)
	print("command")
	pass
	#TODO put current hand item into potty 
	#for slot_data in inventory_data.slot_datas:
		#var slot = Slot.instantiate()
		#item_grid.add_child(slot)
		#
		#slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		#
		#if slot_data:
			#slot.set_slot_data(slot_data)
