extends BaseEventScript

func setup(d: BaseEventFormat, sc : MDSEScene):
	data = d
	mdse_scene = sc
	
	var no_load := false
	
	for entry in data.entries:
		
		var res := MDResource.new()
		
		res.name = str(entry.data["gfx"]) # lol
		
		mdse_scene.res_pool.add_resource(res)
		
		res.load_filepath(str(entry.data["gfx"])+":")
		
		if not res.load_format("General.Art"): 
			no_load = true
		
		res.data.parameters["offset"] = entry.data["vram"]
		
		
		if not res.load_compression("Nemesis"): 
			no_load = true
		
		if no_load:
			mdse_scene.res_pool.delete_resource(res)
			continue
		
		res.load_data(str(entry.data["gfx"])+":")
		
		mdse_scene.vram.load_vram(res.data, res.data.parameters["offset"])
		
		mdse_scene.res_pool.delete_resource(res)
		
	
