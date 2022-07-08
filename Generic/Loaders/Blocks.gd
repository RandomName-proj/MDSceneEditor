extends Node

var level : Node
const block_size := Vector2(2,2)
var block_handler := BlockHandler.new(0x800, block_size)

func _init(level : Node):
	self.level = level
	level.get_node("TilePlanes").add_child(block_handler)
	block_handler.owner = level

func load_file(path):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	
	var block_arr : Array
	var tile_arr : Array
	
	for block in range(0, int(file.get_len()/8)):
		var blk = DataFormats.Block.new(block_size)
		
		for tile in range(0, block_size.x*block_size.y):
			blk.tile_indexes[tile] = tile_arr.size()
			
			var tl := DataFormats.Tile.new()
			var tile_data := file.get_buffer(2)
			tl.vram = (((tile_data[0] & 0b111) << 8) + tile_data[1]) * 64 # tile's graphics vram position
			tl.flip_x = tile_data[0] & 0b1000
			tl.flip_y = tile_data[0] & 0b10000
			tl.palette = (tile_data[0] & 0b1100000) >> 5
			tl.priority = tile_data[0] & 0b10000000 
			
			tile_arr.append(tl)
		
		block_arr.append(blk)
		
	
	block_handler.load_data([block_arr,tile_arr])
