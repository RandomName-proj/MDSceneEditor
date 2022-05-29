extends Node

const palLines : int = 4
var update : bool
var palette : PoolColorArray
var pal_texture : ImageTexture
const MD_COLOR_ARRAY : Array = [0, 52, 87, 116, 144, 172, 206, 255]

func md_color_to_rgb8(md_color: int) -> Color:
	var red = (md_color>>1)&0b111
	var green = (md_color>>(4+1))&0b111
	var blue = (md_color>>(8+1))&0b111
	red = MD_COLOR_ARRAY[red]
	green = MD_COLOR_ARRAY[green]
	blue = MD_COLOR_ARRAY[blue]
	
	return Color8(red,green,blue)

# Called when the node enters the scene tree for the first time.
func _ready():
	pal_texture = ImageTexture.new()
	palette.resize(64)


func _process(delta):
	pass

func load_file(path):
	
	var file = File.new()
	file.open(path,File.READ_WRITE)
	file.endian_swap = true
	
	#	Convert palette to RGB8
	for i in range(min(64,file.get_len()/2)):
		palette[i] = md_color_to_rgb8(file.get_16())
	
	
	var img := Image.new()
	img.create(palette.size(),1,false,Image.FORMAT_RGB8)
	img.lock()
	
	for color in range(palette.size()):
		img.set_pixel(color,0,palette[color])
	
	img.unlock()
	pal_texture.create_from_image(img,0)
	
	file.close()
