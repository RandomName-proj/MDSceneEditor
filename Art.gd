extends Node


var tex : ImageTexture = ImageTexture.new()
var img : Image = Image.new()
var artFile : File = File.new()
var artTiles: int # Amount of tiles in art file
var artBuffer: PoolByteArray
var palLine : int = 0
var palNode : Node
var update : bool = false

signal Updated

func _ready():
	palNode = get_parent().get_node("Palette")
	update = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_chgpalline"):
		palLine += 1
		palLine &= 3
		update = true
	if update:
		_redraw()
	

func _redraw():
	
	emit_signal("Updated")
	
	if artBuffer.empty():
		return
	
	artTiles = artBuffer.size()/64
	
	$Sprite.position.x = get_viewport().size.x/2
	$Sprite.position.y = 128
	
	img.create(min(artTiles,8)*8,artTiles/8*8+8,false,Image.FORMAT_RGB8)
	
	
	img.lock()
	
	var row : int
	var collumn : int
	
	for tile in range(artTiles):
		row = tile/8*8
		collumn = (tile%8)*8
#		Draw one 8x8 tile
		for rowOff in range(8):
			for collumnOff in range(8):
				var pix = artBuffer[collumnOff+rowOff*8+tile*64]
				img.set_pixel(collumnOff+collumn,rowOff+row,palNode.palette[pix+palLine*16])
	
	
	img.unlock()
	tex.create_from_image(img, 0) # Disable filtering, mipmaps and texture repeating
	$Sprite.texture = tex
	update = false

func _on_FileSelect_file_selected(path):
	loadXBppImage(path,4)
#	artFile.open(path,File.READ)
#	artFile.endian_swap = true
#	artBuffer.resize(0)
	
#	Copy art file data into buffer and make it 8bpp, so working with it is easier
#	for i in artFile.get_len():
#		var pix = artFile.get_8()
#		artBuffer.append((pix>>4)&0xF)
#		artBuffer.append(pix&0xF)
	 
#	artFile.close()
#	
#	update = true

# loads and converts X(X<=8 and X%2 = 0 or X == 1) Bpp Image to 8 Bpp
func loadXBppImage(path,bpp: int):
	artFile.open(path,File.READ)
	artFile.endian_swap = true
	artBuffer.resize(0)
	
	update = true
	
#	Copy art file data into buffer and make it 8bpp, so working with it is easier
#	for i in artFile.get_len():
#		var pix = artFile.get_8()
#		artBuffer.append((pix>>4)&0xF)
#		artBuffer.append(pix&0xF)
	
	for byte in artFile.get_len():
		var pix = artFile.get_8()
		
#		artBuffer.append((pix>>4)&0xF)
#		artBuffer.append(pix&0xF)
		for bits in range(8-bpp,-bpp,-bpp):
			artBuffer.append((pix>>bits)&((1<<bpp)-1))
		
		
	
	artFile.close()
	

func _on_Palette_Updated():
	update = true
