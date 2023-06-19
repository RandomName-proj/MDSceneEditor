extends Sprite2D

var tile_set_texture : Texture2D # the vram texture


func load_blocks(data: BaseBlockFormat, tile_size : Vector2i):
	var image = Image.create(data.block_size.x*data.entries.size(),data.block_size.y,false,Image.FORMAT_RGBAF)
	
	material.set_shader_parameter("tile_set_texture",tile_set_texture)
	material.set_shader_parameter("tex_width",tile_set_texture.get_width())
	material.set_shader_parameter("tex_width",tile_set_texture.get_height())
	
	material.set_shader_parameter("tile_width",8)
	material.set_shader_parameter("tile_height",8)
	
	material.set_shader_parameter("tile_rows",tile_set_texture.get_width()/8)
	
	var tile := 1.0/2.0 # yeah
	
	for x in range(2):
		for y in range(2):
			image.set_pixel(x,y,Color(tile,0,0,255))
	
	texture = ImageTexture.create_from_image(image)
