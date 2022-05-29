extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var chunk_arr : Array
var block_node : Node

class Chunk:
	var block_ids : Array
	var block_flips : Array
	var block_solids : Array
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_file(path):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	
	# load all blocks from the file
	for chunk in range(0, file.get_len() / 512):
		var chk := Chunk.new()
		
		chk.block_ids.resize(256)
		chk.block_flips.resize(256)
		chk.block_solids.resize(256)
		
		for block in range(0, 256):
			var block_data := file.get_16()
			
			var block_id := block_data & 0b001111111111
			var block_flip_x : bool = block_data & 0b100000000000
			var block_flip_y : bool = block_data & 0b1000000000000
			var block_solid := block_data & 0b0110000000000000
			
			chk.block_ids[block] = block_id
			chk.block_flips[block] = [block_flip_x, block_flip_y]
			chk.block_solids[block] = block_solid
			
		
		chunk_arr.append(chk)
		
	
	place_chunk(0, 0, 2)

func place_chunk(x: int, y: int, id: int):
	var chk : Chunk = chunk_arr[id]
	for block in range(0, 256):
		var block_x := x * 16 + (block & 15)
		var block_y := y * 16 + (block / 16)
		block_node.place_block(block_x, block_y, 
			chk.block_ids[block], false, false)
