extends Node2D

@onready var tilemap := $SubViewportContainer/SubViewport/TileMap

func load_texture(texture : Texture2D):
	tilemap.texture = texture

func load_blocks(data: BaseBlockFormat, tile_size : Vector2i):
	tilemap.load_blocks(data, tile_size)
	# calculate how much pixels will take all the blocks placed linearly from left to right
	var scr_size : Vector2 = tile_size*data.block_size*data.entries.size() # note : block size is in tiles so it is multiplied by tile size
	
	# and use that as a viewport size
	$SubViewportContainer/SubViewport.size = scr_size

func get_block_texture():
	return $SubViewportContainer/SubViewport.get_texture()

# returns block size in pixels
func get_block_size():
	return tilemap.tile_set.tile_size*tilemap.data.block_size
