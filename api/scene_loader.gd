extends Node
class_name SceneLoader

static func load_scene(path : String, res_pool : MDResourcePool):
	var scene_script : Dictionary = JSON.parse_string(FileAccess.get_file_as_string(path))
	
	if scene_script == null:
		Global.console.printerr("failed to open scene script file")
		return
	
	#TODO: implement rom loading
	
	for res_script in scene_script["resources"]:
		var res = MDResource.new()
		res.name = res_script["name"]
		res.load_filepath(res_script["data"])
		res_pool.add_resource(res)
		res.load_format(res_script["formatter"])
		res.load_compression(res_script["compressor"])
		res.load_data(res_script["data"])
		if res_script.has("parameters"):
			res.data.parameters = res_script["parameters"]
		if res_script.has("required"):
			res.data.required = res_script["required"]
	

static func save_scene(path : String, res_pool : MDResourcePool):
	pass
