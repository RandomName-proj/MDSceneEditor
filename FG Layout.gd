extends TileMap


var is_update_needed := false

#func do_force_update(layer : int = -1):
#	is_update_needed = true

func _tile_data_runtime_update(layer, coords, tile_data):
	# TODO: implement it properly
	tile_data.modulate.g = 0.5

func _use_tile_data_runtime_update(layer : int, coords : Vector2i):
	return is_update_needed

func load_blocks(data: BaseFormat):
	var source := TileSetAtlasSource.new()
	#source.texture = get_parent().get_node("VRAM").texture
	source.use_texture_padding = false # tileset doesn't load vram texture if it's set to True
	source.texture = get_parent().get_node("VRAM").texture
	#print(source.get_tile_at_coords(Vector2i(4,4)))
	source.texture_region_size = Vector2i(8,8)
	print(source.texture.get_size())
	print(source.get_atlas_grid_size())
	for i in range(source.get_atlas_grid_size().x):
		source.create_tile(Vector2(i,0))
	
	
	tile_set.add_source(source,0)
	set_cell(0,Vector2i(0,0),0,Vector2i(0,0))
	set_cell(0,Vector2i(1,0),0,Vector2i(1,0))
	set_cell(0,Vector2i(2,0),0,Vector2i(2,0))
	set_cell(0,Vector2i(3,0),0,Vector2i(3,0))
	
	is_update_needed = true
	#force_update()
	#is_update_needed = false
	
