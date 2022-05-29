extends Node

var img : Image = Image.new()
var tex : Texture = ImageTexture.new()
var art_buffer: PoolByteArray

func _ready():
	img.create(64*1024*2/8,8,false,Image.FORMAT_RGBAF)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_file(path, start_vram):
	return _load_xbpp_image(path, 4, start_vram)

# loads and converts X(X<=8 and X%2 = 0 or X == 1) Bpp Image to 8 Bpp
func _load_xbpp_image(path,bpp: int, start_vram):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	art_buffer.resize(0)
	
	for byte in range(file.get_len()):
		var pix = file.get_8()
		
		for bits in range(8-bpp,-bpp,-bpp):
			art_buffer.append((pix>>bits)&((1<<bpp)-1))
		
	
	
	file.close()
	
	
	img.lock()
	
	var start_pix : int = start_vram & 63
	var start_tile := int(start_vram / 64)
	var start_col := (start_pix & 7) + start_tile * 8
	var start_row := int(start_pix / 8)
	
	for el in range(art_buffer.size()):
		var pix := el & 63
		var tile := int(el / 64)
		var col := start_col + (pix & 7) + tile * 8
		var row := start_row + int(pix / 8)
		
		if art_buffer[pix + tile*64] != 0:
			img.set_pixel(col, row, Color8(art_buffer[pix + tile*64],0,0))
		else:
			img.set_pixel(col, row, Color.transparent)
	
	
	img.unlock()
	tex.create_from_image(img,0)
	return art_buffer.size() 
