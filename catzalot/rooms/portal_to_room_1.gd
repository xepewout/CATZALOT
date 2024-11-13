extends Area2D
	


func _on_body_entered(body):
	var main_scene = get_tree().root.get_node("Main")
	main_scene.load_room("res://rooms/test_room.tscn")
