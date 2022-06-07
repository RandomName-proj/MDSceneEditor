extends Script

const chunk_size := Vector2(16,16)
const chunk_table_size := 0x52

static func get_init_args():
	return {"chunk_size": chunk_size, "chunk_table_size": chunk_table_size}

static func load_file(file : File, data, load_entry, offset : int = 0, length : int = 0):
	var load_end : int
	
	if length == 0:
		load_end = (offset + 1)  + int(file.get_len()/2/chunk_size.x/chunk_size.y)
	else:
		load_end = (offset + 1) + length
	
	load_end = min(data.size(),load_end)
	
	# First chunk in S1 is always blank
	data[0] = DataFormats.Chunk.new(chunk_size) 
	
	for chunk in range(offset + 1, load_end):
		for block in range(0, chunk_size.x*chunk_size.y):
			var block_data := file.get_buffer(2)
			
			var block_id := ((block_data[0] & 0b11) << 8) + block_data[1]
			var block_flip_x : bool = block_data[0] & 0b1000
			var block_flip_y : bool = block_data[0] & 0b10000
			var block_solid := block_data[0] & 0b1100000
			
			
			data[chunk].block_ids[block] = block_id
			data[chunk].block_flips[block] = [block_flip_x, block_flip_y]
			data[chunk].block_solids[block] = block_solid
		
		
		
	
	return load_end
