extends Node2D

@onready var tilemap := $SubViewport/TileMap

func load_texture(texture : Texture2D):
	tilemap.tile_set_texture = texture

func load_blocks(data: BaseBlockFormat, tile_size : Vector2i):
	tilemap.load_blocks(data, tile_size)
	# calculate how much pixels will take all the blocks placed linearly from left to right
	var scr_size : Vector2 = data.block_size # note : block size is in tiles so it is multiplied by tile size
	
	scr_size.x *= data.entries.size()
	
	# and use that as a viewport size
	$SubViewport.size = scr_size

func get_block_texture():
	return $SubViewport.get_texture()

# returns block size in pixels
func get_block_size():
	return tilemap.tile_set.tile_size*tilemap.data.block_size
