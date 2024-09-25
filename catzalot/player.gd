extends RigidBody2D
signal hit
signal toggle_inventory

@export var inventory_data:InventoryData
@onready var interact_ray = $InteractRay
@onready var camera_2d = $Camera2D

@export var speed = 100
var hp = 100
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
	if Input.is_action_pressed("move_up"):
		velocity.y -=1
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	if Input.is_action_just_pressed("interact"):
		interact()
	if velocity.length()>0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0

func interact()->void:
	if interact_ray.is_colliding():
		#print("interacting with", interact_ray.get_collider())
		#var collider = interact_ray.get_collider()
		interact_ray.get_collider().player_interact()

func _on_body_entered(body):
	print("hit")
	# Player disappears after being hit.
	#hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	#$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	#$CollisionShape2D.disabled = false

func get_drop_position() -> Vector2:
	return self.global_position + Vector2(20,0)

func hit_damage():
	pass # Replace with function body.
