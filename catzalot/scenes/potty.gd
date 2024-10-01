extends Area2D

var time_accumulator = 0.0
@export var follow_delay = 1
@export var speed = 25
var player_pos: Vector2
var lerpys: Vector2


func _ready():
	pass

func _get_player_pos(playerPosition: Vector2):
	player_pos = playerPosition
	print("player_pos set to", player_pos)
	
func _process(delta):
	
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
	
	
	
