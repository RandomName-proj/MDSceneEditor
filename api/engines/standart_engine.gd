extends Node
class_name StandartEngine

@onready var paletter_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/BackBufferCopy/Paletter"
@onready var blocks_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/Blocks"
@onready var chunks_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/Chunks"
@onready var tile_layout_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/TileLayout"
@onready var tile_layout2_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/TileLayout2"

func load_scene():
	
	owner.res_pool.add_resource("vram")
	var vram : MDResource = owner.res_pool.get_resource("vram")
	vram.load_format("res://user/formatters/art.gd")
	vram.load_compression("res://user/compressors/nemesis.gd")
	vram.load_data("res://test data/art/LZ.bin")
	owner.vram.load_vram(vram.data, 0)
	
	owner.res_pool.add_resource("palette")
	var palette : MDResource = owner.res_pool.get_resource("palette")
	palette.load_format("res://user/formatters/palette.gd")
	palette.load_compression("res://user/compressors/uncompressed.gd")
	palette.load_data("res://test data/palettes/Sonic+LZ.pal")
	
	owner.palette.load_palette(palette.data)
	
	paletter_node.material = owner.palette.material
	
	
	owner.res_pool.add_resource("blocks")
	var blocks : MDResource = owner.res_pool.get_resource("blocks")
	blocks.load_format("res://user/formatters/sonic/16x16_blocks.gd")
	blocks.load_compression("res://user/compressors/enigma.gd")
	blocks.load_data("res://test data/blocks/LZ.bin")
	
	blocks_node.load_texture(owner.vram.texture)
	blocks_node.load_blocks(blocks.data, Vector2i(8,8))
	
	var blk_texture : Texture2D = blocks_node.get_block_texture()
	
	
	owner.res_pool.add_resource("chunks")
	var chunks : MDResource = owner.res_pool.get_resource("chunks")
	chunks.load_format("res://user/formatters/sonic/sonic 1/chunks.gd")
	chunks.load_compression("res://user/compressors/kosinski.gd")
	chunks.load_data("res://test data/chunks/LZ.bin")
	
	chunks_node.load_texture(blk_texture)
	chunks_node.load_chunks(chunks.data,Vector2(16,16))
	
	var chk_texture : Texture2D = chunks_node.get_chunk_texture()
	
	owner.res_pool.add_resource("tile_layout")
	var tile_layout : MDResource = owner.res_pool.get_resource("tile_layout")
	tile_layout.load_format("res://user/formatters/sonic/sonic 1/tile_layout.gd")
	tile_layout.load_compression("res://user/compressors/uncompressed.gd")
	tile_layout.load_data("res://test data/tile layout/lz1.bin")
	
	tile_layout_node.load_texture(chk_texture)
	tile_layout_node.load_tile_layout(tile_layout.data,Vector2(256,256))
	
	owner.res_pool.add_resource("tile_layout_bg")
	var tile_layout_bg : MDResource = owner.res_pool.get_resource("tile_layout_bg")
	tile_layout_bg.load_format("res://user/formatters/sonic/sonic 1/tile_layout.gd")
	tile_layout_bg.load_compression("res://user/compressors/uncompressed.gd")
	tile_layout_bg.load_data("res://test data/tile layout/lzbg.bin")
	
	tile_layout2_node.load_texture(chk_texture)
	tile_layout2_node.load_tile_layout(tile_layout_bg.data,Vector2(256,256))
	
