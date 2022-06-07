extends Script

static func get_init_args():
	return {}

static func load_file(file : File, data, load_entry, offset : int = 0, length : int = 0):
	var load_end : int
	if length == 0:
		load_end = offset + int(file.get_len()*2)
	else:
		load_end = offset + int(length)
	
	load_end = min(data.size(),load_end)
	
	for pix in range(offset, load_end, 2):
		var pixel_pair = file.get_8()
		data[pix] = pixel_pair & 0b1111
		data[pix+1] = pixel_pair >> 4
	
	return load_end
