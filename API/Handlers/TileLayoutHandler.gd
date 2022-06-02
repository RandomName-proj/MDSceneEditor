extends Node

var fg_layout : Array
var bg_layout : Array

func load_data(data):
	fg_layout = data[0]
	bg_layout = data[1]

func draw_layout(tile_handler : Node, block_handler: Node, chunk_handler : Node):
	for row in range(0, fg_layout.size()):
		for col in range(0, fg_layout[row].size()):
			chunk_handler.place_chunk(col, row, fg_layout[row][col], block_handler, tile_handler, "FG")
	
	for row in range(0, bg_layout.size()):
		for col in range(0, bg_layout[row].size()):
			chunk_handler.place_chunk(col, row, bg_layout[row][col], block_handler, tile_handler, "BG")
	
