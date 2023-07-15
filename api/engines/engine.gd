extends Node
class_name StandartEngine

@onready var paletter_node := $"../CanvasLayer/HardwareContainer/HardwareViewport/BackBufferCopy/Paletter"

@onready var blocks_scene = preload("res://layers/blocks/blocks.tscn")
@onready var chunks_scene = preload("res://layers/chunks/chunks.tscn")


func load_scene():
	
	# creating the nodes for data
	
	for res in owner.res_pool.get_all_resources():
		match res.data.get_format():
			"BaseBlockFormat":
				owner.block_sets.add_tile_set(res.name)
			"BaseChunkFormat":
				owner.chunk_sets.add_tile_set(res.name)
			"BaseTileLayoutFormat":
				owner.get_plane(res.data.required["plane"]).add_tile_layout(res.name)
			"BaseObjectLayoutFormat":
				owner.object_layer_sets.add_object_layer(res.name)
	
	# loading the data
	for res in owner.res_pool.get_all_resources():
		match res.data.get_format():
			"BasePaletteFormat":
				owner.palette.load_palette(res.data)
			"BaseArtFormat":
				owner.vram.load_vram(res.data, 0)
			"BaseBlockFormat":
				var blocks_node = owner.block_sets.find_tile_set(res.name) 
				blocks_node.load_texture(owner.vram.texture)
				blocks_node.load_tile_set(res.data, Vector2i(8,8))
			"BaseChunkFormat":
				var blocks_res_name : String = res.data.required["art"]
				var blocks_node = owner.block_sets.find_tile_set(blocks_res_name) 
				
				var chunks_node = owner.chunk_sets.find_tile_set(res.name) 
				chunks_node.load_texture(blocks_node.get_tile_texture())
				chunks_node.load_tile_set(res.data,blocks_node.get_tile_size())
			"BaseTileLayoutFormat":
				var chunks_res_name : String = res.data.required["tile_set"]
				var chunks_node = owner.chunk_sets.find_tile_set(chunks_res_name)
				
				var tile_layout_node = owner.get_plane(res.data.required["plane"]).find_tile_layout(res.name)
				tile_layout_node.load_texture(chunks_node.get_tile_texture())
				tile_layout_node.load_tile_layout(res.data,chunks_node.get_tile_size())
			"BaseObjectLayoutFormat":
				var object_layer_node = owner.object_layer_sets.find_object_layer(res.name)
				object_layer_node.load_object_layout(res.data, owner)
		
	
	paletter_node.material = owner.palette.material
