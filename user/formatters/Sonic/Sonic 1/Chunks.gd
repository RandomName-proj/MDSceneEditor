extends GenericChunkFormatter

const chunk_size := Vector2(16,16)

func format(data: PackedByteArray) -> BaseFormat:
	var chunks := BaseChunkFormat.new()
	
	chunks.tile_size = chunk_size
	
	var first_chunk := BaseChunkEntry.new(chunk_size,1)
	chunks.entries.append(first_chunk)
	
	
	var chk_ind := 0
	while chk_ind < data.size():
		var new_chunk := BaseChunkEntry.new(chunk_size,1)
		for blk_ind in range(0, chunk_size.x*chunk_size.y):
			var new_block := BaseChunkEntry.Block.new()
			var block_data : int = (data[chk_ind+blk_ind*2]<<8)+data[chk_ind+blk_ind*2+1]
			
			new_block.index = block_data & 0b1111111111
			new_block.flags = block_data >> 3+8 & 0b11
			new_block.solids = [block_data >> 5+8 & 0b11]
			
			new_chunk.blocks[blk_ind] = new_block
		
		chunks.entries.append(new_chunk)
		
		chk_ind += chunk_size.x*chunk_size.y*2 # go to the next chunk
	
	return chunks

func deformat(data: BaseFormat) -> PackedByteArray:
	
	var raw_data := PackedByteArray()
	
	var chunks := data.entries
	chunks.pop_front() # delete the first chunk because it isn't represntend in the raw data
	
	for chk in chunks:
		for blk in chk.blocks:
			var raw_block : int = 0
			# block index
			raw_block |= blk.index
			
			# flip flags
			
			raw_block |= blk.flags << 3+8 # x
			
			# solid layers
			
			raw_block |= blk.solids[0] << 5+8
			
			raw_data.append(raw_block>>8)
			raw_data.append(raw_block&0xFF)
	
	
	return raw_data
