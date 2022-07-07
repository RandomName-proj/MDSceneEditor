extends Node
class_name BlockHandler

var block_arr : Array
var tile_handler := TileHandler.new()

func _init(block_arr_size, default_block_size):
	for block in range(0, block_arr_size):
		block_arr.append(DataFormats.Block.new(default_block_size))
	
	
	add_child(tile_handler)

func load_data(data):
	for block in range(0, data[0].size()):
		block_arr[block] = data[0][block]
	
	tile_handler.load_data(data[1])

func place_block(x : int, y : int, id : int, plane, flip_x := false, flip_y := false):
	var blk : DataFormats.Block = block_arr[id]
	for tile in range(0,blk.size.x*blk.size.y):
		var tile_x : int = x * blk.size.x + abs(wrapi(tile,0,blk.size.x) - int(flip_x))
		var tile_y : int = y * blk.size.y + abs(int(tile/blk.size.x) - int(flip_y))
		tile_handler.place_tile(tile_x, tile_y, blk.tile_indexes[tile], 
			plane, flip_x, flip_y)
