extends Node

var image : Image = Image.new()
var texture : ImageTexture

func _init():
	clear()
	texture = ImageTexture.create_from_image(image)

func clear():
	image = Image.create(64*1024*2/8,8,false,Image.FORMAT_RGBAF)

func load_vram(data: BaseFormat, start_vram: int):
	
	
	var start_pix : int = (start_vram * 2) & 63
	var start_tile := int((start_vram * 2) / 64)
	var start_col := (start_pix & 7) + start_tile * 8
	var start_row := int(start_pix / 8)
	
	for el in range(data.entries.size()):
		var pix := el & 63 # current pixel 
		var tile := int(el / 64) # current tile 
		var col := start_col + (pix & 7) + tile * 8 # current column
		var row := (start_row + int(pix / 8)) & 7 # current row
		
		var pix_color : Color = data.entries[pix+tile*64].color
		
		
		if pix_color.r != 0:
			image.set_pixel(col, row, Color(pix_color.r,1,0,1)) # pre-multiply by 4 to optimize shader
		else:
			image.set_pixel(col, row, Color(0, 0, 0, 0))
	
	
	print("Image loaded")
	
	texture.update(image)
