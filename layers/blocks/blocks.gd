extends Node2D

@onready var tilemap := $SubViewport/TileMap

func load_texture(texture : Texture2D):
	tilemap.texture = texture

func load_tile_set(data: BaseBlockFormat, tex_tile_size : Vector2i):
	tilemap.load_tile_set(data, tex_tile_size)
	# calculate how much pixels will take all the blocks placed linearly from left to right
	var scr_size : Vector2 = tex_tile_size*data.tile_size # note : block size is in tiles so it is multiplied by tile size
	
	scr_size *= data.entries.size()
	
	# and use that as a viewport size
	$SubViewport.size = scr_size

func get_tile_texture():
	return $SubViewport.get_texture()

# returns tile size in pixels
func get_tile_size():
	return tilemap.tile_set.tile_size*tilemap.data.tile_size
