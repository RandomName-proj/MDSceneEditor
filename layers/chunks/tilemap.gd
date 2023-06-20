extends TileMap

#var data : BaseFormat # the chunk data
var texture : Texture2D # the block texture
var is_update_needed := false # if set to true, metadata of all tiles is updated 

func _use_tile_data_runtime_update(layer : int, coords : Vector2i):
	return is_update_needed

func _tile_data_runtime_update(layer, coords, tile_data):
	
	var alternative_id := get_cell_alternative_tile(0, coords)
	
	tile_data.flip_h = alternative_id % 2
	tile_data.flip_v = alternative_id / 2

func load_chunks(data: BaseChunkFormat, block_size : Vector2i):
	tile_set = TileSet.new()
	tile_set.tile_size = block_size
	
	#self.data = data
	var source := TileSetAtlasSource.new()
	source.use_texture_padding = false # tileset doesn't load the texture if it's set to true
	source.texture = self.texture # use the block texture
	source.texture_region_size = block_size
	
	# make a tileset out of texture
	for i in range(source.get_atlas_grid_size().x):
		source.create_tile(Vector2(i,0))
		# make alternative id for the flipped tiles
		for j in range(1,4): 
			source.create_alternative_tile(Vector2(i,0),j)
	
	tile_set.add_source(source,0)
	
	# place chunks linearly from left to right
	
	for chunk_ind in range(data.entries.size()):
		for y in range(data.chunk_size.y):
			for x in range(data.chunk_size.x):
				var blk : BaseChunkEntry.Block = data.entries[chunk_ind].blocks[x+y*data.chunk_size.x]
				set_cell(0, Vector2(x+chunk_ind*data.chunk_size.x,y),0,Vector2(blk.index,0),blk.flags&0b11)
	
	set_cell(0,Vector2(1,1),0,Vector2(1,1),0)
	
	is_update_needed = true
	force_update()
	await RenderingServer.frame_pre_draw
	is_update_needed = false
