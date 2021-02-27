extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tex : ImageTexture = ImageTexture.new()
var img : Image = Image.new()
const palLines : int = 4
var update: bool = false
var palette : PoolColorArray
export var palEntrySize: Vector2 = Vector2(16,16)
const genColorArr : Array = [0, 52, 87, 116, 144, 172, 206, 255]

signal Updated

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
	palette.resize(64)
	loadPal("standart.pal")
	
	$Sprite.position = Vector2(palEntrySize.x*4/2,palEntrySize.y*16/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if update:
		_redraw()

func _redraw():
	
	
	emit_signal("Updated")
	
	
	img.create(palEntrySize.x*4,palEntrySize.y*16,false,Image.FORMAT_RGB8)
	img.lock()
	
	
	var row: int
	var collumn: int
	for palIndex in range(palette.size()):
		row = palIndex%16*palEntrySize.x
		collumn = palIndex/16*palEntrySize.y
		# Draw One Palette Entry
		for rowOff in range(palEntrySize.y):
			for collumnOff in range(palEntrySize.x):
				img.set_pixel(collumnOff+collumn,rowOff+row,palette[palIndex])
	
	img.unlock()
	tex.create_from_image(img,0) # Disable filtering, mipmaps and texture repeating
	$Sprite.texture = tex
	update = false


func _on_FileSelect_file_selected(path):
	loadPal(path)

func loadPal(path):
	var file = File.new()
	file.open(path,File.READ_WRITE)
	file.endian_swap = true
	update = true
	
	#	Convert palette to RGB8
	for i in range(min(64,file.get_len()/2)):
		palette[i] = genColorToRGB8(file.get_16())
	
	file.close()
