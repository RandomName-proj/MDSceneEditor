extends Node
class_name StandartEngine

@onready var paletter_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/BackBufferCopy/Paletter"
@onready var vram_view_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/VRAMView"

@onready var block_sets := $"../BlockSets"
@onready var chunk_sets := $"../ChunkSets"

@onready var blocks_scene = preload("res://layers/blocks/blocks.tscn")
@onready var chunks_scene = preload("res://layers/chunks/chunks.tscn")


func load_scene():
	
	# creating the nodes for data
	
	for res in owner.res_pool.get_all_resources():
		if (res.data.get_format() is BaseBlockFormat):
			block_sets.add_tile_set(res.name)
		
		elif (res.data.get_format() is BaseChunkFormat):
			chunk_sets.add_tile_set(res.name)
		
		elif (res.data.get_format() is BaseTileLayoutFormat):
			owner.get_plane(res.data.get_required("plane")).add_tile_layout(res.name)
	
	# loading the data
	for res in owner.res_pool.get_all_resources():
		if (res.data.get_format() is BasePaletteFormat):
			owner.palette.load_palette(res.data)
		
		elif (res.data.get_format() is BaseArtFormat):
			owner.vram.load_vram(res.data, 0)
		
		elif (res.data.get_format() is BaseBlockFormat):
			var blocks_node = block_sets.find_tile_set(res.name) 
			blocks_node.load_texture(owner.vram.texture)
			blocks_node.load_tile_set(res.data, Vector2i(8,8))
		
		elif (res.data.get_format() is BaseChunkFormat):
			var blocks_res_name : String = res.data.get_required("art")
			var blocks_node = block_sets.find_tile_set(blocks_res_name) 
			
			var chunks_node = chunk_sets.find_tile_set(res.name) 
			chunks_node.load_texture(blocks_node.get_tile_texture())
			chunks_node.load_tile_set(res.data,blocks_node.get_tile_size())
		
		elif (res.data.get_format() is BaseTileLayoutFormat):
			var chunks_res_name : String = res.data.get_required("tile_set")
			var chunks_node = chunk_sets.find_tile_set(chunks_res_name)
			
			var tile_layout_node = owner.get_plane(res.data.get_required("plane")).find_tile_layout(res.name)
			tile_layout_node.load_texture(chunks_node.get_tile_texture())
			tile_layout_node.load_tile_layout(res.data,chunks_node.get_tile_size())
		
	
	vram_view_node.texture = owner.vram.texture
	
	paletter_node.material = owner.palette.material
