extends BaseObjectScript

func setup():
	mdse_scene.connect("loaded_scene",_on_scene_loaded_scene)

func _on_scene_loaded_scene():
	
	var frame : int = Num.to_int(metadata["frame"])
	
	var map := mdse_scene.res_pool.get_resource(metadata["mappings"])
	
	add_child(MDSpriteHelper.load_mapping(map.data.entries[frame].maps,Num.to_int(metadata["vram_offset"]),data.flags,mdse_scene.vram.texture))
	
