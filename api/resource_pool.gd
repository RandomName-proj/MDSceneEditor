extends Node
class_name MDResourcePool

signal resource_changed(resource: MDResource)

func delete_all_resources():
	for kid in get_children():
		remove_child(kid)
		kid.queue_free()
	

func add_resource(res_name: String):
	if find_resource(res_name) != null:
		Global.console.printerr("Resource "+"'"+res_name+"'"+" already exists")
	else:
		var res := MDResource.new()
		res.name = res_name
		add_child(res)

func get_resource(res_name : String) -> MDResource:
	if find_resource(res_name) == null:
		Global.console.printerr("Resource "+"'"+res_name+"'"+" wasn't found")
		return
	else:
		return get_node(res_name)

func copy_resource(res: MDResource):
	if find_resource(res.name) != null:
		Global.console.printerr("Resource "+"'"+res.name+"'"+" already exists")
	else:
		# duplicate function doesn't work so I decided to copy all variables manually instead 
		var copy_res := MDResource.new()
		copy_res.name = res.name
		copy_res.format = res.format
		copy_res.compression = res.compression
		copy_res.filepath = res.filepath
		add_child(copy_res)

func find_resource(res_name: String) -> Node:
	return find_child(res_name, false, false)

func get_all_resources() -> Array[Node]:
	return get_children()
