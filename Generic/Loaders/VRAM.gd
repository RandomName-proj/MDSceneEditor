extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level : Node

func _init(level : Node):
	self.level = level

func load_file(path):
	_load_xbpp_image(path, 4, 0)

# loads and converts X(X<=8 and X%2 = 0 or X == 1) Bpp Image to 8 Bpp
func _load_xbpp_image(path,bpp: int, start_vram):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	var art_buffer : PoolByteArray
	
	for byte in range(file.get_len()):
		var pix = file.get_8()
		
		for bits in range(8-bpp,-bpp,-bpp):
			art_buffer.append((pix>>bits)&((1<<bpp)-1))
		
	
	
	file.close()
	level.vram.load_data(art_buffer, start_vram)
