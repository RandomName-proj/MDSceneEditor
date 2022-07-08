extends Node
class_name BlockHandler

var block_arr : Array
var tile_handler := TileHandler.new()
var block_size : Vector2

func _init(block_arr_size, block_size):
	self.block_size = block_size
	
	for block in range(0, block_arr_size):
		block_arr.append(DataFormats.Block.new(block_size))
	
	
	add_child(tile_handler)

func load_data(data):
	for block in range(0, data[0].size()):
		block_arr[block] = data[0][block]
	
	tile_handler.load_data(data[1])

func place_block(x : int, y : int, id : int, plane, tilemap, flip_x := false, flip_y := false):
	var blk : DataFormats.Block = block_arr[id]
	for tile in range(0,block_size.x*block_size.y):
		var tile_x : int = x * block_size.x + abs(wrapi(tile,0,block_size.x) - int(flip_x))
		var tile_y : int = y * block_size.y + abs(int(tile/block_size.x) - int(flip_y))
		tile_handler.place_tile(tile_x, tile_y, blk.tile_indexes[tile], 
			plane, tilemap, flip_x, flip_y)
