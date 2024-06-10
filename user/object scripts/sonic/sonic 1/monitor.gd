extends BaseObjectScript

func setup(d : BaseObjectLayoutEntry, meta: Dictionary, sc : MDSEScene):
	
	data = d
	mdse_scene = sc
	metadata = meta
	
	self.position = Vector2i(data.x_pos, data.y_pos)
	
	self.name = "Monitor"
	
	mdse_scene.connect("loaded_scene",_on_scene_loaded_scene)

func _on_scene_loaded_scene():
	
	print(data.additional["subtype"])
	
	var frame = data.additional["subtype"] + 2
	
	var map := mdse_scene.res_pool.get_resource(metadata["mappings"])
	
	add_child(MDSpriteHelper.load_mapping(map.data.entries[frame].maps,0x680,mdse_scene.vram.texture))
	


func _process(delta):
	pass
