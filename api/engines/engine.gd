extends Node
class_name StandartEngine

@onready var paletter_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/BackBufferCopy/Paletter"
@onready var vram_view_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/VRAMView"
@onready var tile_layout_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/TileLayout"

@onready var tile_sets := $"../TileSets"

@onready var blocks_scene = preload("res://layers/blocks/blocks.tscn")
@onready var chunks_scene = preload("res://layers/chunks/chunks.tscn")
@onready var tile_layout_scene = preload("res://layers/tile_layout/tile_layout.tscn")


func load_scene():
	
	# creating the nodes for data
	
	for res in owner.res_pool.get_all_resources():
		if (res.data.get_format() is BaseBlockFormat):
			var blocks_node := blocks_scene.instantiate()
			blocks_node.name = res.name
			tile_sets.add_child(blocks_node)
		
		elif (res.data.get_format() is BaseChunkFormat):
			var chunks_node := chunks_scene.instantiate()
			chunks_node.name = res.name
			tile_sets.add_child(chunks_node)
		
		elif (res.data.get_format() is BaseTileLayoutFormat):
			pass
	
	# loading the data
	for res in owner.res_pool.get_all_resources():
		if (res.data.get_format() is BasePaletteFormat):
			owner.palette.load_palette(res.data)
		
		elif (res.data.get_format() is BaseArtFormat):
			owner.vram.load_vram(res.data, 0)
		
		elif (res.data.get_format() is BaseBlockFormat):
			var blocks_node := tile_sets.find_child(res.name, false, false) 
			blocks_node.load_texture(owner.vram.texture)
			blocks_node.load_blocks(res.data, Vector2i(8,8))
		
		elif (res.data.get_format() is BaseChunkFormat):
			var blocks_res_name : String = res.data.get_required("art")
			var blocks_node := tile_sets.find_child(blocks_res_name, false, false) 
			
			var chunks_node = tile_sets.find_child(res.name, false, false) 
			chunks_node.load_texture(blocks_node.get_block_texture())
			chunks_node.load_chunks(res.data,blocks_node.get_block_size())
		
		elif (res.data.get_format() is BaseTileLayoutFormat):
			var chunks_res_name : String = res.data.get_required("tile_set")
			var chunks_node := tile_sets.find_child(chunks_res_name, false, false) 
			
			tile_layout_node.load_texture(chunks_node.get_chunk_texture())
			tile_layout_node.load_tile_layout(res.data,Vector2(256,256))
		
	
	vram_view_node.texture = owner.vram.texture
	
	paletter_node.material = owner.palette.material
