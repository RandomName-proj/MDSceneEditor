extends Node

var level : Node
const chunk_size := Vector2(8,8)
var chunk_handler := ChunkHandler.new(0x100, chunk_size)

func _init(level : Node):
	self.level = level
	level.get_node("TilePlanes").add_child(chunk_handler)
	chunk_handler.owner = level

func load_file(path):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	
	var chunk_arr : Array
	
	while file.get_position() < file.get_len():
		var chk := DataFormats.Chunk.new(chunk_size)
		
		for block in range(0, chunk_size.x*chunk_size.y):
			var block_data := file.get_buffer(2)
			
			var block_id := ((block_data[0] & 0b11) << 8) + block_data[1]
			var block_flip_x : bool = block_data[0] & 0b100
			var block_flip_y : bool = block_data[0] & 0b1000
			var block_solid : Array
			block_solid.append(block_data[0] & 0b110000) # 1st collision layer
			block_solid.append(block_data[0] & 0b11000000) # 2nd collision layer
			
			chk.block_ids[block] = block_id
			chk.block_flips[block] = [block_flip_x, block_flip_y]
			chk.block_solids[block] = block_solid
			
		
		chunk_arr.append(chk)
		
	
	chunk_handler.load_data(chunk_arr)
