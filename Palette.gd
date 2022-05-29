extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var pal_entry_size: Vector2 = Vector2(16,16)

# Called when the node enters the scene tree for the first time.
func _ready():
	var img := Image.new()
	var tex := ImageTexture.new()
	
	img.create(4,16,false,Image.FORMAT_RGBAF)
	img.lock()
	
	for row in range(16):
		for col in range(4):
			img.set_pixel(col, row, Color8(col * 16 + row,0,0))
	
	img.unlock()
	tex.create_from_image(img,0)
	$Sprite.texture = tex
	$Sprite.material.set_shader_param("palette",PaletteHandler.pal_texture)
	
	$Sprite.scale = pal_entry_size
	$Sprite.position = Vector2(pal_entry_size.x*4/2,pal_entry_size.y*16/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _redraw():
#	
#	var palLineSize : int
#	palLineSize = PaletteHandler.palette.size()/PaletteHandler.palLines
#	img.create(PaletteHandler.palLines,palLineSize,false,Image.FORMAT_RGB8)
#	img.lock()
#	
#	
#	var row: int
#	var collumn: int
#	for palIndex in range(PaletteHandler.palette.size()):
#		row = palIndex%16
#		collumn = palIndex/16
#		# Draw One Palette Entry
#		img.set_pixel(collumn,row,PaletteHandler.palette[palIndex])
#	
#	img.unlock()
#	var tex := ImageTexture.new()
#	tex.create_from_image(img,0) # Disable filtering, mipmaps and texture repeating
#	$Sprite.texture = tex

#func _on_PaletteHandler_Update():
#	update = true
