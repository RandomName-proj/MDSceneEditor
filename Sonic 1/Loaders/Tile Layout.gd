extends Script

static func load_file(path):
	return [_load_plane(path[0]), _load_plane(path[1])]

static func _load_plane(path):
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
