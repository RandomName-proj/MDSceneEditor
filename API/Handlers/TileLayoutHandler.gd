extends Node

var tile_layout_arr : Array
var tile_layout_size
var tile_plane : String

func init_data(init_args: Dictionary):
	var tile_layout_data : Dictionary
	
	tile_layout_data["size"] = Vector2(64,8)
	tile_layout_data["layout"] = []
	
	for chunk in range(init_args["layout_max_size"]):
		tile_layout_data["layout"].append(0)
	
	return tile_layout_data

func load_data(data, load_entry):
	tile_layout_arr = data["layout"]
	tile_layout_size = data["size"]
	tile_plane = load_entry["plane"]

func draw_layout(tile_handler : Node, block_handler: Node, chunk_handler : Node):
	for row in range(0, tile_layout_size.x):
		for col in range(0, tile_layout_size.y):
			chunk_handler.place_chunk(col, row, tile_layout_arr[row * tile_layout_size.x + col], 
				block_handler, tile_handler, tile_plane)
	
