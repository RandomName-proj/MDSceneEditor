extends Node
class_name ObjectLayoutHandler

func load_data(data):
	for child in get_children():
		child.queue_free()
	
	
	for obj in data:
		var object_scene : PackedScene = load("res://Object Scenes/Template Object/Object.tscn")
		var object_nodes : Node = object_scene.instance()
		object_nodes.position = obj.pos
		object_nodes.id = obj.id
		object_nodes.subtype = obj.subtype
		add_child(object_nodes)
