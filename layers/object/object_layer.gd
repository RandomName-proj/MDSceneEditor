extends Node2D

@export var object_scene = preload("res://layers/object/object.tscn")

var mdse_scene : Node2D
var object_layer_script : Dictionary

func load_object_layer_script(script : String):
	
	# load the script
	object_layer_script = JSON.parse_string(FileAccess.get_file_as_string(script))
	

func load_object_layout(data: BaseObjectLayoutFormat, mdse_scene : Node2D):
	self.mdse_scene = mdse_scene
	
	# load the resources from the object layer
	
	SceneLoader.load_resources(object_layer_script["resources"], mdse_scene.res_pool)
	
	object_layer_script = object_layer_script["objects"]
	
	for obj in data.entries:
			var object_node := object_scene.instantiate()
			add_child(object_node)
			object_node.position = Vector2(obj.x_pos, obj.y_pos)
			object_node.id = obj.id
			object_node.flags = obj.flags
			object_node.additional = obj.additional
			if object_layer_script.has(str(obj.id)): # find the object script for the corresponding object id
				object_node.object_script = object_layer_script[str(obj.id)]
			object_node.mdse_scene = mdse_scene
