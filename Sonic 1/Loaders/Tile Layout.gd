extends Node

var level : Node
var fg_handler := TileLayoutHandler.new()
var bg_handler := TileLayoutHandler.new()

func _init(level : Node):
	self.level = level
	level.get_node("TilePlanes/FG").add_child(fg_handler)
	fg_handler.owner = level
	level.get_node("TilePlanes/BG").add_child(bg_handler)
	bg_handler.owner = level

func load_file(path):
	fg_handler.load_data(_load_plane(path[0]))
	bg_handler.load_data(_load_plane(path[1]))

func _load_plane(path):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	
	var tile_layout : Array
	var tile_layout_size := Vector2(file.get_8() + 1,file.get_8() + 1)
	
	for row in range(0, tile_layout_size.y):
		var lay_row := [] 
		for col in range(0, tile_layout_size.x):
			lay_row.append(file.get_8() & 127)
		tile_layout.append(lay_row)
	
	return tile_layout
