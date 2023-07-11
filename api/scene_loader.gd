extends Node
class_name SceneLoader

static func load_scene(path : String, res_pool : MDResourcePool) -> bool:
	var scene_script = JSON.parse_string(FileAccess.get_file_as_string(path))
	
	if scene_script == null:
		Global.console.printerr("Failed to open scene script file")
		return false
	
	#TODO: implement rom loading
	
	var no_load := false
	
	for res_script in scene_script["resources"]:
		
		var res = MDResource.new()
		res.name = res_script["name"]
		
		res.load_filepath(res_script["data"])
		
		if not res.load_format(res_script["formatter"]): 
			no_load = true
		
		if res_script.has("parameters"):
			for param in res_script["parameters"]:
				if (res.data.parameters.has(param)):
					res.data.parameters[param] = res_script["parameters"][param]
				else:
					Global.console.printwarn("[MDResource:'{name}']: Invalid parameter field '{field}'".format({"name":res.name, "field": param}))
		
		if res_script.has("required"):
			for req in res_script["required"]:
				if (res.data.required.has(req)):
					res.data.required[req] = res_script["required"][req]
				else:
					Global.console.printwarn("[MDResource:'{name}']: Invalid requierd field '{field}'".format({"name":res.name, "field": req}))
			
			for req in res.data.required:
				if (res.data.required[req] == null):
					Global.console.printerr("[MDResource:'{name}']: Required '{field}' field is undefined".format({"name":res.name, "field": req}))
					no_load = true
		
		if not res.load_compression(res_script["compressor"]): 
			no_load = true
		
		if no_load:
			print(no_load)
			continue
		
		res.load_data(res_script["data"])
		res_pool.add_resource(res)
	
	return (not no_load)

static func save_scene(path : String, res_pool : MDResourcePool):
	pass
