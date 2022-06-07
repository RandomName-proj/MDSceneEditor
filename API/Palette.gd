extends Node
class_name Palette

var palette : PoolColorArray
var texture := ImageTexture.new()
const MD_COLOR_ARRAY : Array = [0, 52, 87, 116, 144, 172, 206, 255]

func md_color_to_rgb8(md_color: int) -> Color:
	var red = (md_color>>1)&0b111
	var green = (md_color>>(4+1))&0b111
	var blue = (md_color>>(8+1))&0b111
	red = MD_COLOR_ARRAY[red]
	green = MD_COLOR_ARRAY[green]
	blue = MD_COLOR_ARRAY[blue]
	
	return Color8(red,green,blue)

func _init():
	for _i in range(0,64):
		palette.append(Color.black)


func load_file(path, offset):
	
	var file = File.new()
	file.open(path,File.READ_WRITE)
	file.endian_swap = true
	
	var pal_end := min(64, file.get_len()/2 + offset) # color on which loading of this palette file ends
	
	#	Convert palette to RGB8
	for i in range(min(64,file.get_len()/2)):
		palette[i+offset] = md_color_to_rgb8(file.get_16())
	
	
	var img := Image.new()
	img.create(palette.size(),1,false,Image.FORMAT_RGB8)
	img.lock()
	
	for color in range(palette.size()):
		img.set_pixel(color,0,palette[color])
	
	img.unlock()
	texture.create_from_image(img,0)
	
	file.close()
	return pal_end
