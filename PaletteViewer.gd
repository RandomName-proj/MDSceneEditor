extends Sprite2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@export var pal_entry_size: Vector2 = Vector2(16,16)

# Called when the node enters the scene tree for the first time.
func load_palette(palette : BaseFormat):
	var img := Image.new()
	var tex := ImageTexture.new()
	
	img = Image.create(4,16,false,Image.FORMAT_RGBAF)
	
	
	for row in range(16):
		for col in range(4):
			#img.set_pixel(col, row, Color8((col * 16 + row)*4,0,0)) # pre-multiply by 4 to optimize shader
			img.set_pixel(col, row, palette.entries[col*16 + row].color)
	
	tex = ImageTexture.create_from_image(img)
	
	texture = tex
	#modulate = Color.BLACK
	scale = pal_entry_size
	#position = Vector2(pal_entry_size.x*4/2,pal_entry_size.y*16/2)
