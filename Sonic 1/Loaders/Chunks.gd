extends Node

var level : Node
const chunk_size := Vector2(16,16)
var chunk_handler := ChunkHandler.new(0x53, chunk_size)

func _init(level : Node):
	self.level = level
	level.get_node("TilePlanes").add_child(chunk_handler)
	chunk_handler.owner = level

func load_file(path):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	
	var chunk_arr : Array
	
	# in S1 first chunk is empty chunk
	var first_chunk := DataFormats.Chunk.new(chunk_size)
	
	chunk_arr.append(first_chunk)
	
	while file.get_position() < file.get_len():
		var chk := DataFormats.Chunk.new(chunk_size)
		
		for block in range(0, chunk_size.x*chunk_size.y):
			var block_data := file.get_buffer(2)
			
			var block_id := ((block_data[0] & 0b11) << 8) + block_data[1]
			var block_flip_x : bool = block_data[0] & 0b1000
			var block_flip_y : bool = block_data[0] & 0b10000
			var block_solid := block_data[0] & 0b1100000
			
			
			chk.block_ids[block] = block_id
			chk.block_flips[block] = [block_flip_x, block_flip_y]
			chk.block_solids[block] = block_solid
		
		
		chunk_arr.append(chk)
		
	
	chunk_handler.load_data(chunk_arr)
