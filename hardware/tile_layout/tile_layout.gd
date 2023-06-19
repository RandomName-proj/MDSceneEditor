extends Node2D


@onready var tilemap := $TileMap

func load_texture(texture : Texture2D):
	tilemap.texture = texture

func load_tile_layout(data: BaseTileLayoutFormat, chunk_size : Vector2i):
	tilemap.load_tile_layout(data, chunk_size)
	pass

# returns chunk size in pixels
func get_tile_layout_size(): 
	return tilemap.tile_set.tile_size*tilemap.data.layout_size
