extends Script

const block_size := Vector2(2,2)
const block_table_size := 0x300

static func get_init_args():
	return {"block_size": block_size, "block_table_size": block_table_size}

static func load_file(file : File, data, load_entry, offset : int = 0, length : int = 0):
	var load_end : int
	
	if length == 0:
		load_end = offset + int(file.get_len()/2/block_size.x/block_size.y)
	else:
		load_end = offset + length
	
	load_end = min(data[0].size(),load_end)
	
	for block in range(offset, load_end):
		for tile in range(0, block_size.x*block_size.y):
			var tile_off := block_size.x * block_size.y
			
			data[0][block].tile_indexes[tile] = tile + tile_off
			
			var tile_data := file.get_buffer(2)
			data[1][tile + tile_off].vram = (((tile_data[0] & 0b111) << 8) + tile_data[1]) * 64 # tile's graphics vram position
			data[1][tile + tile_off].flip_x = tile_data[0] & 0b1000
			data[1][tile + tile_off].flip_y = tile_data[0] & 0b10000
			data[1][tile + tile_off].palette = (tile_data[0] & 0b1100000) >> 5
			data[1][tile + tile_off].priority = tile_data[0] & 0b10000000 
			
		
	
	return load_end
