extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var block_arr : Array

func init_data(init_args : Dictionary):
	var block_data : Array
	
	for block in range(init_args["block_table_size"]):
		block_data.append(DataFormats.Block.new(init_args["block_size"]))
	
	return [block_data, $TileHandler.init_data(init_args)]

func load_data(data, load_entry):
	block_arr = data[0]
	$TileHandler.load_data(data[1], load_entry)

func place_block(x : int, y : int, id : int, tile_handler : Node, plane := "FG", flip_x := false, flip_y := false):
	var blk : DataFormats.Block = block_arr[id]
	for tile in range(0,blk.size.x*blk.size.y):
		var tile_x : int = x * blk.size.x + abs(wrapi(tile,0,blk.size.x) - int(flip_x))
		var tile_y : int = y * blk.size.y + abs(int(tile/blk.size.x) - int(flip_y))
		$TileHandler.place_tile(tile_x, tile_y, blk.tile_indexes[tile], 
			plane, flip_x, flip_y)
