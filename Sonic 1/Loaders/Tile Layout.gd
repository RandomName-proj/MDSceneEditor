extends Script

const layout_max_size : int = 64*8

static func get_init_args():
	return {"layout_max_size": layout_max_size}

static func load_file(file : File, data, load_entry, offset : int = 0, length : int = 0):
	var load_end : int
	
	var tile_layout_size := Vector2(file.get_8() + 1,file.get_8() + 1)
	
	load_end = offset + tile_layout_size.x * tile_layout_size.y
	
	load_end = min(data.size(),load_end)
	
	
	for chunk in range(offset, load_end):
		data[chunk] = file.get_8() & 127
	
	#for row in range(0, tile_layout_size.y):
	#	var lay_row := [] 
	#	for col in range(0, tile_layout_size.x):
	#		lay_row.append(file.get_8() & 127)
	#	tile_layout.append(lay_row)
	
	return load_end
