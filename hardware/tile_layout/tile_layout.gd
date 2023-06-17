extends Node2D


@onready var tilemap := $SubViewportContainer/SubViewport/TileMap

func load_texture(texture : Texture2D):
	tilemap.texture = texture

func load_tile_layout(data: BaseTileLayoutFormat, chunk_size : Vector2i):
	tilemap.load_tile_layout(data, chunk_size)
	# calculate how much pixels will take the layout
	var scr_size : Vector2 = chunk_size*data.layout_size*data.entries.size() # note : chunk size is in chunks so it is multiplied by chunk size in pixels
	
	# and use that as a viewport size
	$SubViewportContainer/SubViewport.size = Vector2(1024*10,1024*10)

func get_tile_layout_texture():
	return $SubViewportContainer/SubViewport.get_texture()

# returns chunk size in pixels
func get_tile_layout_size(): 
	return tilemap.tile_set.tile_size*tilemap.data.layout_size
