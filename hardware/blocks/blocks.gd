extends Node

@onready var tilemap := $SubViewportContainer/SubViewport/TileMap

func load_texture(texture : Texture2D):
	tilemap.texture = texture

func load_blocks(data: BaseFormat):
	tilemap.load_blocks(data)
	# calculate how much pixels will take all the blocks placed linearly from left to right
	var scr_size : Vector2 = Vector2i(8,8)*data.block_size*data.entries.size() # note : block size is in tiles so it is multiplied by tile size
	
	# and use that as a viewport size
	$SubViewportContainer/SubViewport.size = scr_size

func get_block_texture():
	return $SubViewportContainer/SubViewport.get_texture()
