extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var img : Image = Image.new()
var update : bool
export var palEntrySize: Vector2 = Vector2(16,16)
const genColorArr : Array = [0, 52, 87, 116, 144, 172, 206, 255]

# Called when the node enters the scene tree for the first time.
func _ready():
	PaletteHandler.connect("Update",self,"_on_PaletteHandler_Update")
	update = true
	$Sprite.scale = palEntrySize
	$Sprite.position = Vector2(palEntrySize.x*4/2,palEntrySize.y*16/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if update:
		_redraw()
	update = false

func _redraw():
	
	var palLineSize : int
	palLineSize = PaletteHandler.palette.size()/PaletteHandler.palLines
	img.create(PaletteHandler.palLines,palLineSize,false,Image.FORMAT_RGB8)
	img.lock()
	
	
	var row: int
	var collumn: int
	for palIndex in range(PaletteHandler.palette.size()):
		row = palIndex%16
		collumn = palIndex/16
		# Draw One Palette Entry
		img.set_pixel(collumn,row,PaletteHandler.palette[palIndex])
	
	img.unlock()
	var tex := ImageTexture.new()
	tex.create_from_image(img,0) # Disable filtering, mipmaps and texture repeating
	$Sprite.texture = tex

func _on_PaletteHandler_Update():
	update = true
