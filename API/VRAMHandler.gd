extends Node
class_name VRAMHandler

var image : Image = Image.new()
var texture : Texture = ImageTexture.new()

func _init():
	image.create(64*1024*2/8,8,false,Image.FORMAT_RGBAF)
	texture.create_from_image(image,0)

func clear():
	image.create(64*1024*2/8,8,false,Image.FORMAT_RGBAF)

func load_data(data, start_vram):
	image.lock()
	
	var start_pix : int = start_vram & 63
	var start_tile := int(start_vram / 64)
	var start_col := (start_pix & 7) + start_tile * 8
	var start_row := int(start_pix / 8)
	
	for el in range(data.size()):
		var pix := el & 63
		var tile := int(el / 64)
		var col := start_col + (pix & 7) + tile * 8
		var row := start_row + int(pix / 8)
		
		if data[pix + tile*64] != 0:
			image.set_pixel(col, row, Color8(data[pix + tile*64]*4,0,0)) # pre-multiply by 4 to optimize shader
		else:
			image.set_pixel(col, row, Color.transparent)
	
	
	image.unlock()
	texture.create_from_image(image,0)
