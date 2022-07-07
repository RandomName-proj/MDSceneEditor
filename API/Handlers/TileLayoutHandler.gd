extends Node
class_name TileLayoutHandler

var layout : Array

func load_data(data):
	layout = data

func draw(plane):
	for row in range(0, layout.size()):
		for col in range(0, layout[row].size()):
			plane.get_handler(ChunkHandler).place_chunk(col, row, layout[row][col], plane)
	
	#for row in range(0, bg_layout.size()):
	#	for col in range(0, bg_layout[row].size()):
	#		chunk_handler.place_chunk(col, row, bg_layout[row][col], block_handler, "BG")
	
