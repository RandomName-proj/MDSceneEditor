extends Node
class_name VRAMHandler

var image : Image = Image.new()
var texture : Texture = ImageTexture.new()

func _init():
	image.create(64*1024*2/8,8,false,Image.FORMAT_RGBAF)
	texture.create_from_image(image,0)

func init_data(init_args : Dictionary):
	var data : PoolByteArray
	for _i in range(64*1024*2):
		data.append(0)
	
	return data

func load_data(data, load_entry):
	image.create(64*1024*2/8,8,false,Image.FORMAT_RGBAF)
	image.lock()
	
	for el in range(data.size()):
		var pix := el & 63
		var tile := int(el / 64)
		var col := (pix & 7) + tile * 8
		var row := int(pix / 8)
		
		if data[pix + tile*64] != 0:
			image.set_pixel(col, row, Color8(data[pix + tile*64]*4,0,0)) # pre-multiply by 4 to optimize shader
		else:
			image.set_pixel(col, row, Color.transparent)
	
	
	image.unlock()
	texture.create_from_image(image,0)
