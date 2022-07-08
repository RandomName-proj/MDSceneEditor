extends Node
class_name TileLayoutHandler

var layout : Array

func load_data(data):
	layout = data

func draw(plane, tilemap : TileMap):
	for row in range(0, layout.size()):
		for col in range(0, layout[row].size()):
			plane.get_handler(ChunkHandler).set_chunk(col, row, layout[row][col], plane, tilemap)
	

func get_chunk(x: int, y: int):
	return layout[y][x]
