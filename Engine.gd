extends Node

func do_the_thing():
	
	owner.res_pool.add_resource("vram")
	var vram : MDResource = owner.res_pool.get_resource("vram")
	vram.load_format("res://user/formatters/Art.gd")
	vram.load_compression("res://user/compressors/nemesis.gd")
	vram.load_data("res://test data/art/LZ.bin")
	owner.vram.load_vram(vram.data, 0)
	
	owner.res_pool.add_resource("palette")
	var palette : MDResource = owner.res_pool.get_resource("palette")
	palette.load_format("res://user/formatters/Palette.gd")
	palette.load_compression("res://user/compressors/uncompressed.gd")
	palette.load_data("res://test data/palettes/Sonic+LZ.pal")
	
	owner.get_node("CanvasLayer/HardwareContainer/HardwareViewport/BackBufferCopy/Paletter").material = load("res://palette_shader_material.tres")
	owner.get_node("CanvasLayer/HardwareContainer/HardwareViewport/BackBufferCopy/Paletter").material.set_shader_parameter("palette",palette.data.colors)
	
	owner.res_pool.add_resource("blocks")
	var blocks : MDResource = owner.res_pool.get_resource("blocks")
	blocks.load_format("res://user/formatters/Sonic/16x16 Blocks.gd")
	blocks.load_compression("res://user/compressors/enigma.gd")
	blocks.load_data("res://test data/blocks/LZ.bin")
	
	owner.get_node("CanvasLayer/HardwareContainer/HardwareViewport/Blocks").load_texture(owner.vram.texture)
	owner.get_node("CanvasLayer/HardwareContainer/HardwareViewport/Blocks").load_blocks(blocks.data)
	
