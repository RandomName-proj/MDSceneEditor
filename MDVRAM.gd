extends Node

var img : Image = Image.new()
var tex : Texture = ImageTexture.new()
var artBuffer: PoolByteArray
var palLine : int = 0
var palNode : Node
var update : bool

func _ready():
	img.create(64*1024*2/8,8,false,Image.FORMAT_RGBAF)
	PaletteHandler.connect("Update",self,"_on_PaletteHandler_Update")
	update = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#if update:
	#	_redraw()
	#update = false
	pass

func _redraw():
	
	var artTiles := artBuffer.size()/64
	
	img.create(artTiles * 8, 8, false,Image.FORMAT_RGBAF)
	
	if artBuffer.empty():
		return
	
	img.lock()
	
	var collumn : int
	
	for tile in range(artTiles):
		collumn = tile*8
		# Draw one 8x8 tile
		for rowOff in range(8):
			for collumnOff in range(8):
				var pix = artBuffer[collumnOff+collumn+rowOff*8]
				if pix != 0:
					img.set_pixel(collumn+collumnOff,rowOff,PaletteHandler.palette[pix+palLine*16])
				else:
					img.set_pixel(collumn+collumnOff,rowOff,Color.transparent)
	
	img.unlock()
	tex.create_from_image(img,0)

func loadFile(path, startoff):
	_loadXBppImage(path, 4, startoff)

# loads and converts X(X<=8 and X%2 = 0 or X == 1) Bpp Image to 8 Bpp
func _loadXBppImage(path,bpp: int, startoff):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	artBuffer.resize(0)
	
	for byte in file.get_len():
		var pix = file.get_8()
		
		for bits in range(8-bpp,-bpp,-bpp):
			artBuffer.append((pix>>bits)&((1<<bpp)-1))
		
	
	file.close()
	
	update = true
	
	img.lock()
	

	for el in range(artBuffer.size()):
		var pix := el & 63
		var tile := int(el / 64)
		var col := (pix & 7) + tile * 8
		var row := int(pix / 8)
		
		if artBuffer[pix + tile*64] != 0:
			img.set_pixel(col, row, Color8(artBuffer[pix + tile*64],0,0,255))
		else:
			img.set_pixel(col, row, Color.transparent)
	
	
#	for pix in range(artBuffer.size()):
#		print(artBuffer[pix])
#		if artBuffer[pix] != 0:
#			img.set_pixel((pix & 63) + tile * 64,(pix / 64) & 7, Color(artBuffer[pix],0,0,255))
#		else:
#			img.set_pixel((pix & 63) + tile * 64,(pix / 64) & 7, Color.transparent)
	
	img.unlock()
	tex.create_from_image(img,0)

func _on_PaletteHandler_Update():
	update = true
