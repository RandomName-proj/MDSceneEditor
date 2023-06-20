extends TileMap

var texture : Texture2D # the block texture

func load_tile_layout(data: BaseTileLayoutFormat, chunk_size : Vector2i):
	tile_set = TileSet.new()
	tile_set.tile_size = chunk_size
	
	var source := TileSetAtlasSource.new()
	source.use_texture_padding = false # tileset doesn't load the texture if it's set to true
	source.texture = self.texture # use the block texture
	source.texture_region_size = chunk_size
	
	# make a tileset out of texture
	for i in range(source.get_atlas_grid_size().x):
		source.create_tile(Vector2(i,0))
	
	tile_set.add_source(source,0)
	
	# place chunks
	
	for y in range(data.layout_size.y):
		for x in range(data.layout_size.x):
			var chunk : int = data.entries[x+y*data.layout_size.x].chunk_id
			set_cell(0, Vector2(x,y),0,Vector2(chunk,0),0)
	
	
