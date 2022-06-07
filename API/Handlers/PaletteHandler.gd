extends Node
class_name PaletteHandler

var palette : PoolColorArray
var texture := ImageTexture.new()
const MD_COLOR_ARRAY : Array = [0, 52, 87, 116, 144, 172, 206, 255]

func pal_to_color(entry: int) -> Color:
	var red = (entry>>1)&0b111
	var green = (entry>>(4+1))&0b111
	var blue = (entry>>(8+1))&0b111
	red = MD_COLOR_ARRAY[red]
	green = MD_COLOR_ARRAY[green]
	blue = MD_COLOR_ARRAY[blue]
	
	return Color8(red,green,blue)


func _init():
	for _i in range(64):
		palette.append(Color.black)

func init_data(init_args : Dictionary):
	var data : Array
	
	for _i in range(64):
		data.append(0)
	
	return data

func load_data(data, load_entry):
	#	Convert palette to RGB color
	for entry in range(data.size()):
		palette[entry] = pal_to_color(data[entry])
	
	
	var img := Image.new()
	img.create(palette.size(),1,false,Image.FORMAT_RGB8)
	img.lock()
	
	for color in range(palette.size()):
		img.set_pixel(color,0,palette[color])
	
	img.unlock()
	texture.create_from_image(img,0)
