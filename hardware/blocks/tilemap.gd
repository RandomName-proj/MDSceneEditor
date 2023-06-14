extends TileMap

var data : BaseFormat
var texture : Texture2D # the vram texture
var is_update_needed := false # if set to true, metadata of all tiles is updated

func _tile_data_runtime_update(layer, coords, tile_data):
	# TODO: implement it properly
	
	var alternative_id := get_cell_alternative_tile(0, coords)
	
	tile_data.flip_h = (alternative_id >> BaseBlockEntry.Tile.x_bit) & 1
	tile_data.flip_v = (alternative_id >> BaseBlockEntry.Tile.y_bit) & 1
	
	var block_id : int = coords.x / 2
	var tile_id : int = coords.y * 2 + coords.x % 2
	var tile_metadata : BaseBlockEntry.Tile = data.entries[block_id].tiles[tile_id]
	
	tile_data.modulate.g = (1 - 0.25*tile_metadata.palette) # set palette

func _use_tile_data_runtime_update(layer : int, coords : Vector2i):
	return is_update_needed

func load_blocks(data: BaseFormat):
	self.data = data
	var source := TileSetAtlasSource.new()
	source.use_texture_padding = false # tileset doesn't load vram texture if it's set to True
	source.texture = self.texture # use the vram texture
	source.texture_region_size = Vector2i(8,8) # size of each tile
	
	
	# make a 8x8 tileset out of vram texture
	for i in range(source.get_atlas_grid_size().x):
		source.create_tile(Vector2(i,0))
		for j in range(1,4): 
			source.create_alternative_tile(Vector2(i,0),j)
	
	tile_set.add_source(source,0)
	
	
	# place blocks linearly from left to right
	
	for block_ind in range(data.entries.size()):
		for y in range(data.block_size.y):
			for x in range(data.block_size.x):
				var tile : BaseBlockEntry.Tile = data.entries[block_ind].tiles[x+y*2]
				set_cell(0, Vector2(x+block_ind*data.block_size.x,y),0,Vector2(tile.tile_offset,0),tile.flags&0b11)
	
	
	is_update_needed = true
	force_update()
	#await RenderingServer.frame_pre_draw
	#is_update_needed = false
	
