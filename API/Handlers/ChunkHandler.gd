extends Node

var chunk_arr : Array
var chunk_counter : int = 0

func load_data(data):
	chunk_arr = data

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

func place_chunk(x: int, y: int, id: int, block_handler : Node, tile_handler: Node, plane := "FG"):
	var chk : DataFormats.Chunk = chunk_arr[id]
	for block in range(0, chk.size.x*chk.size.y):
		var block_x := x * chk.size.x + wrapi(block,0,chk.size.x)
		var block_y := y * chk.size.y + int(block / chk.size.x)
		
		
		block_handler.place_block(block_x, block_y, chk.block_ids[block], tile_handler, plane, 
			chk.block_flips[block][0], chk.block_flips[block][1])
