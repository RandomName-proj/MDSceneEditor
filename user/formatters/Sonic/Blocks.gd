extends GenericBlockFormatter

func format(data: PackedByteArray) -> BaseFormat:
	Global.console.printerr("This formatter isn't meant to be used")
	return BaseFormat.new()

func deformat(data: BaseFormat) -> PackedByteArray:
	Global.console.printerr("This formatter isn't meant to be used")
	return PackedByteArray()

func _do_format(data: PackedByteArray, block_size: Vector2) -> BaseFormat:
	var blocks := BaseBlockFormat.new()
	
	var blk_ind := 0
	while blk_ind < data.size():
		var new_block := BaseBlockEntry.new(block_size)
		for tile_ind in range(0, block_size.x*block_size.y):
			var new_tile := BaseBlockEntry.Tile.new()
			var block_data : int = (data[blk_ind+tile_ind*2]<<8) + data[blk_ind+tile_ind*2+1]
			new_tile.vram_offset = (block_data & 0b11111111111) << 5
			new_tile.flags = (block_data >> 7+8-2 & 0b100) + (block_data >> 4+8 & 0b11)
			new_tile.palette = block_data >> 6+8 & 0b11
			
			new_block.tiles[tile_ind] = new_tile
		
		blocks.entries.append(new_block)
		
		blk_ind += block_size.x*block_size.y*2 # go to the next chunk
	return blocks

func _do_deformat(data: BaseFormat, block_size: Vector2) -> PackedByteArray:
	var raw_data := PackedByteArray()
	
	var blocks := data.entries
	
	for blk in blocks:
		for tile in blk.tiles:
			var raw_tile : int = 0
			# block index
			
			raw_tile |= (tile.vram_offset >> 5)
			
			# flags
			
			raw_tile |= (tile.flags & 0b100) << 7+8
			raw_tile |= (tile.flags & 0b11) << 6+8
			raw_tile |= (tile.flags & 0b11) << 4+8
			
			
			
			
			raw_data.append(raw_tile<<8)
			raw_data.append(raw_tile&0xFF)
	
	return raw_data
