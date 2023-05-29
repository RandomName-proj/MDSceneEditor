extends BaseEntry
class_name BaseBlockEntry

func _init(tile_size : Vector2):
	tiles.resize(tile_size.x*tile_size.y)
	var null_tile := Tile.new()
	tiles.fill(null_tile)

var tiles : Array[Tile]

class Tile:
	var flags : int = 0 # 1st is priority, 2nd is palette, 3rd is x flip, 4th is y flip
	var palette : int = 0
	enum {prio_bit, x_bit, y_bit}
	
	
	var vram_offset : int = 0
