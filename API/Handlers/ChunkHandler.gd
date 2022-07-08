extends Node
class_name ChunkHandler

var chunk_arr : Array
var chunk_counter : int = 0
var chunk_size : Vector2

func _init(chunk_arr_size, chunk_size):
	self.chunk_size = chunk_size
	
	for chunk in range(0, chunk_arr_size):
		chunk_arr.append(DataFormats.Chunk.new(chunk_size))

func load_data(data):
	for chunk in range(0, data.size()):
		chunk_arr[chunk] = data[chunk]

func _process(_delta):
	#if !chunk_arr.empty():
	#	if Input.is_action_just_pressed("ui_right"):
	#		chunk_counter += 1
	#	if Input.is_action_just_pressed("ui_left"):
	#		chunk_counter -= 1
	#	
	#	chunk_counter = wrapi(chunk_counter, 0, chunk_arr.size())
	#	place_chunk(0, 0, chunk_counter)
	pass

func set_chunk(x: int, y: int, id: int, plane, tilemap):
	var chk : DataFormats.Chunk = chunk_arr[id]
	for block in range(0, chunk_size.x*chunk_size.y):
		var block_x := x * chunk_size.x + wrapi(block,0,chunk_size.x)
		var block_y := y * chunk_size.y + int(block / chunk_size.x)
		
		
		plane.get_handler(BlockHandler).place_block(block_x, block_y, chk.block_ids[block], plane, tilemap, 
			chk.block_flips[block][0], chk.block_flips[block][1])
