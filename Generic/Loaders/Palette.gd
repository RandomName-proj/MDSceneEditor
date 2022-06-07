extends Script

static func get_init_args():
	return {}

static func load_file(file : File, data, load_entry, offset : int = 0, length : int = 0):
	var load_end : int
	if length == 0:
		load_end = offset + int(file.get_len()/2)
	else:
		load_end = offset + length
	
	load_end = min(data.size(),load_end)
	
	for color in range(offset, load_end):
		data[color] = file.get_16()
	
	return load_end
