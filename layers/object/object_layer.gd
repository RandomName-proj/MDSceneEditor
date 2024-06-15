extends Node2D

@export var object_scene = preload("res://layers/object/object.tscn")

var mdse_scene : Node2D
var object_metadata : Dictionary

func load_object_metadata(script : String):
	
	# load the script
	object_metadata = JSON.parse_string(FileAccess.get_file_as_string(script))
	

func load_object_layout(data: BaseObjectLayoutFormat, mdse_scene : Node2D):
	self.mdse_scene = mdse_scene
	
	# load the resources from the object layer
	
	SceneLoader.load_resources(object_metadata["resources"], mdse_scene.res_pool)
	
	object_metadata = object_metadata["objects"]
	
	for obj in data.entries:
			var object_node := object_scene.instantiate()
			add_child(object_node)
			if object_metadata.has(str(obj.id)):
				object_node.load_object(obj,object_metadata[str(obj.id)],mdse_scene)
			else:
				object_node.load_object(obj,{},mdse_scene)
