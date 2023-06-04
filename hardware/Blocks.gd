extends TileMap



var data : BaseFormat
var is_update_needed := false

#func do_force_update(layer : int = -1):
#	is_update_needed = true

func _tile_data_runtime_update(layer, coords, tile_data):
	# TODO: implement it properly
	
	var alternative_id := get_cell_alternative_tile(0, coords)
	#var block_ind : int = int(coords.x/data.block_size.x)
	#var tile_ind : int = (coords.x % data.block_size.x) / 8 + (coords.y % data.block_size.y) / 8 * 2
	#var tile : BaseBlockEntry.Tile = data.entries[block_ind].tiles[tile_ind]
	
	tile_data.flip_h = (alternative_id << BaseBlockEntry.Tile.x_bit) & 1
	#tile_data.flip_h = true
	
	#tile_data.flip_h = (tile.flags << tile.x_bit) & 1
	#tile_data.modulate.g = 1-tile.palette*0.25

func _use_tile_data_runtime_update(layer : int, coords : Vector2i):
	return is_update_needed

func load_blocks(data: BaseFormat):
	self.data = data
	var source := TileSetAtlasSource.new()
	source.use_texture_padding = false # tileset doesn't load vram texture if it's set to True
	source.texture = get_parent().get_node("VRAM").texture
	source.texture_region_size = Vector2i(8,8)
	#print(source.texture.get_size())
	#print(source.get_atlas_grid_size())
	for i in range(source.get_atlas_grid_size().x):
		source.create_tile(Vector2(i,0))
		for j in range(1,4): 
			source.create_alternative_tile(Vector2(i,0),j)
	
	tile_set.add_source(source,0)
	
	#print(data.entries.size())
	
	for block_ind in range(data.entries.size()):
		for y in range(data.block_size.y):
			for x in range(data.block_size.x):
				var tile : BaseBlockEntry.Tile = data.entries[block_ind].tiles[x+y*2]
				set_cell(0, Vector2(x+block_ind*data.block_size.x,y),0,Vector2(tile.tile_offset,0),tile.flags&0b11)
	
	
	is_update_needed = true
	#force_update()
	#is_update_needed = false
	
