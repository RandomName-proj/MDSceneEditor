extends BaseObjectScript

func setup():
	mdse_scene.connect("loaded_scene",_on_scene_loaded_scene)

func _on_scene_loaded_scene():
	
	var frame = data.additional["subtype"] + 2
	
	var map := mdse_scene.res_pool.get_resource(metadata["mappings"])
	
	add_child(MDSpriteHelper.load_mapping(map.data.entries[frame].maps,0x680,0,mdse_scene.vram.texture))
	


func _process(delta):
	pass
