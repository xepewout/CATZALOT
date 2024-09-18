extends Area2D

@export var follow_delay = 0.5
@export var speed = 25
var target_pos: Vector2
var time_accumulator = 0.0

func _ready():
	target_pos = position
	
func _process(delta):
	time_accumulator += delta
	
	if time_accumulator >= follow_delay:
		target_pos = global_position
		time_accumulator = 0
		
	$AnimatedSprite2D.play()
	
	if target_pos != global_position:
		$AnimatedSprite2D.animation = "walk"
	
	if target_pos == global_position:
		$AnimatedSprite2D.animation = "idle"	
		
	global_position = lerp(global_position, target_pos,delta)
	
	
	#independent_movement(delta)
	
#func independent_movement(delta: float) -> void:
	#var random_direction = Vector2(randf() - 0.5, randf() - 0.5).normalized()
	#global_position += random_direction * speed * delta
	
	
	
