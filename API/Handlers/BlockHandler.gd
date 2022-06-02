extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var block_arr : Array


func load_data(data):
	block_arr.clear()
	
	block_arr.append_array(data)
	
	for block in range(data.size(), 2048):
		block_arr.append(DataFormats.Block.new(block_arr[0].size))

func place_block(x : int, y : int, id : int, tile_handler : Node, plane := "FG", flip_x := false, flip_y := false):
	var blk : DataFormats.Block = block_arr[id]
	for tile in range(0,blk.size.x*blk.size.y):
		var tile_x : int = x * blk.size.x + abs(wrapi(tile,0,blk.size.x) - int(flip_x))
		var tile_y : int = y * blk.size.y + abs(int(tile/blk.size.x) - int(flip_y))
		tile_handler.place_tile(tile_x, tile_y, blk.tile_indexes[tile], 
			plane, flip_x, flip_y)
