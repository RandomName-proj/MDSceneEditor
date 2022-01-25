extends Node

const palLines : int = 4
var update : bool
var palette : PoolColorArray
var paltex : ImageTexture
export var palEntrySize: Vector2 = Vector2(16,16)
const genColorArr : Array = [0, 52, 87, 116, 144, 172, 206, 255]
signal Update

func genColorToRGB8(genColor: int) -> Color:
	var red = (genColor>>1)&0b111
	var green = (genColor>>(4+1))&0b111
	var blue = (genColor>>(8+1))&0b111
	red = genColorArr[red]
	green = genColorArr[green]
	blue = genColorArr[blue]
	
	return Color8(red,green,blue)

# Called when the node enters the scene tree for the first time.
func _ready():
	paltex = ImageTexture.new()
	palette.resize(64)
	loadPal("standart.pal")


func _process(delta):
	pass

func loadPal(path):
	
	emit_signal("Update")
	
	var file = File.new()
	file.open(path,File.READ_WRITE)
	file.endian_swap = true
	
	#	Convert palette to RGB8
	for i in range(min(64,file.get_len()/2)):
		palette[i] = genColorToRGB8(file.get_16())
	
	
	var img := Image.new()
	img.create(palette.size(),1,false,Image.FORMAT_RGB8)
	img.lock()
	
	for color in range(palette.size()):
		img.set_pixel(color,0,palette[color])
	
	img.unlock()
	paltex.create_from_image(img,0)
	
	file.close()
