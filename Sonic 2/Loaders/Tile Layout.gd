extends Script

static func load_file(path):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	
	var fg_layout : Array
	var bg_layout : Array
	var tile_layout_size := Vector2(128, 16)
	
	for row in range(0, tile_layout_size.y):
		var lay_row := [] 
		for col in range(0, tile_layout_size.x):
			lay_row.append(file.get_8())
		# even rows are the FG ones, odd are the BG ones
		if row % 2 == 0: 
			fg_layout.append(lay_row)
		else:
			bg_layout.append(lay_row)
		
	
	return [fg_layout, bg_layout]
