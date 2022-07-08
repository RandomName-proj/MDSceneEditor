extends Node
class_name TilePlane

onready var tilemap := MDTilemap.new()

func _ready():
	add_child(tilemap)

func get_handler(type):
	# find this handler in this plane
	for child in get_children():
		if child is type:
			return child
	
	# else find this handler in TilePlanes
	for child in get_parent().get_children():
		if child is type:
			return child
	
	return null

# returns chunk size in pixels
func get_chunk_size() -> Vector2:
	if get_handler(ChunkHandler) != null and get_handler(BlockHandler) != null:
		return get_handler(ChunkHandler).chunk_size * get_handler(BlockHandler).block_size * 8
	else:
		return Vector2(1,1)

func get_chunk_count():
	return get_handler(ChunkHandler).chunk_arr.size()

# returns block size in pixels
func get_block_size() -> Vector2:
	if get_handler(BlockHandler) != null:
		return get_handler(BlockHandler).block_size * 8
	else:
		return Vector2(1,1)

func get_block_count():
	return get_handler(BlockHandler).block_arr.size()

# Assigns plane's tileset to specific tilemap 
func link_tilemap(tilemap : TileMap):
	tilemap.tile_set = get_handler(BlockHandler).tile_handler.tile_set

func set_chunk(x: int, y: int, id: int, tilemap := tilemap):
	if get_handler(ChunkHandler) != null:
		get_handler(ChunkHandler).set_chunk(x, y, id, self, tilemap)

func get_chunk(x: int, y: int):
	return get_handler(TileLayoutHandler).get_chunk(x, y)

func draw():
	get_handler(TileLayoutHandler).draw(self, tilemap)
