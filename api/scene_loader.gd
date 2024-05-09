extends Node
class_name SceneLoader

static func load_scene(path : String, scene : Node2D) -> bool:
	var scene_script = JSON.parse_string(FileAccess.get_file_as_string(path))
	
	if scene_script == null:
		Global.console.printerr("Failed to open scene script file")
		return false
	
	var rom_data := FileAccess.get_file_as_bytes(scene_script["rom"])
	
	if rom_data.is_empty():
		Global.console.printwarn("Failed to open rom file")
	
	var label_data := FileAccess.get_file_as_string(scene_script["labels"])
	
	if label_data.is_empty():
		Global.console.printwarn("Failed to open label file")
	
	if not rom_data.is_empty() and not label_data.is_empty():
		scene.asm_handler.load_labels(rom_data,label_data)
	
	return load_resources(scene_script["resources"], scene.res_pool)

static func load_resources(script : Dictionary, res_pool : MDResourcePool):
	var no_load := false
	
	for res_name in script:
		
		var res_script = script[res_name]
		var res = MDResource.new()
		res.name = res_name
		
		res.load_filepath(res_script["data"])
		
		if not res.load_format(res_script["formatter"]): 
			no_load = true
		
		if res_script.has("parameters"):
			if not load_parameters(res_script["parameters"], res.data.parameters, res.name):
				no_load = true
		
		if res_script.has("required"):
			if not load_required(res_script["required"], res.data.required, res.name):
				no_load = true
		
		if not res.load_compression(res_script["compressor"]): 
			no_load = true
		
		if no_load:
			continue
		
		res.load_data(res_script["data"])
		res_pool.add_resource(res)
	
	return (not no_load)

# loads parameter fields from param_script into param_dict
static func load_parameters(param_script : Dictionary, param_dict : Dictionary, name) -> bool:
	for param in param_script:
		if (param_dict.has(param)):
			param_dict[param] = param_script[param]
		else:
			Global.console.printwarn("[MDResource:'{name}']: Invalid parameter field '{field}'".format({"name":name, "field": param}))
	
	return true

# loads required fields from req_script into req_dict and checks if all the required fields are loaded
static func load_required(req_script : Dictionary, req_dict : Dictionary, name):
	for req in req_script:
		if (req_dict.has(req)):
			req_dict[req] = req_script[req]
		else:
			Global.console.printwarn("[MDResource:'{name}']: Invalid requierd field '{field}'".format({"name":name, "field": req}))
	
	for req in req_dict:
		if (req_dict[req] == null):
			Global.console.printerr("[MDResource:'{name}']: Required '{field}' field is undefined".format({"name":name, "field": req}))
			return false
	
	return true

static func save_scene(path : String, res_pool : MDResourcePool):
	pass
