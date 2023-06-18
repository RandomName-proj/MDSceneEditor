extends Node2D


@onready var tilemap := $SubViewport/TileMap

func load_texture(texture : Texture2D):
	tilemap.texture = texture

func load_chunks(data: BaseChunkFormat, block_size : Vector2i):
	tilemap.load_chunks(data, block_size)
	# calculate how much pixels will take all chunks placed linearly from left to right
	var scr_size : Vector2 = block_size*data.chunk_size*data.entries.size() # note : chunk size is in blocks so it is multiplied by block size in pixels
	
	# and use that as a viewport size
	$SubViewport.size = scr_size

func get_chunk_texture():
	return $SubViewport.get_texture()

# returns chunk size in pixels
func get_chunk_size(): 
	return tilemap.tile_set.tile_size*tilemap.data.chunk_size
