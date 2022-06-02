extends Node

# References to child nodes

var vram := MDVRAM.new()
var palette := Palette.new()
onready var pal_material : ShaderMaterial 
onready var pal_shader = preload("res://API/PalShader.gdshader")
onready var pal_material_tilemap : ShaderMaterial
onready var pal_shader_tilemap : Shader = preload("res://API/PalShaderTilemap.gdshader")

func _ready():
	pal_material = ShaderMaterial.new()
	pal_material.shader = pal_shader
	pal_material.set_shader_param("palette",palette.texture)
	pal_material_tilemap = ShaderMaterial.new()
	pal_material_tilemap.shader = pal_shader_tilemap
	pal_material_tilemap.set_shader_param("palette",palette.texture)


func load_file(jsonFile : String):
	var file = File.new()
	file.open(jsonFile, file.READ)
	var text = file.get_as_text()
	
	if parse_json(text) == null:
		return -1
	
	vram.clear()
	
	
	var dict : Dictionary = parse_json(text)
	file.close()
	
	if dict.has("pal_files"):
		var cur_pal_offset : int = 0
		# TODO : implement proper loading of several palettes
		for pal_file in dict["pal_files"]:
			cur_pal_offset = palette.load_file(pal_file, cur_pal_offset)
			
	
	if dict.has("art_files"):
		var cur_vram : int = 0 # current vram offset of loaded art
		
		for art_file in dict["art_files"]:
			cur_vram = vram.load_file(art_file,cur_vram)
		
	
	if dict.has("loaders"):
		var block_loader : Script = load(dict["loaders"].blocks)
		var chunk_loader : Script = load(dict["loaders"].chunks)
		var tile_layout_loader : Script = load(dict["loaders"].tile_layout)
		var object_layout_loader : Script = load(dict["loaders"].object_layout)
		
		if dict.has("block_files"):
			# TODO : implement proper loading of several block files
			for block_file in dict["block_files"]:
				var block_data = block_loader.load_file(block_file)
				$BlockHandler.load_data(block_data[0])
				$TileHandler.load_data(block_data[1])
		
		if dict.has("chunk_files"):
			# TODO : implement proper loading of several chunk files
			for chunk_file in dict["chunk_files"]:
				var chunk_data = chunk_loader.load_file(chunk_file)
				$ChunkHandler.load_data(chunk_data)
		
		if dict.has("tile_layout_files"):
			# TODO : implement proper loading of several tile layout files
			for tile_layout_files in dict["tile_layout_files"]:
				var tile_layout_data = tile_layout_loader.load_file(tile_layout_files)
				$TileLayoutHandler.load_data(tile_layout_data)
		
		if dict.has("object_layout_files"):
			# TODO : implement proper loading of several object layout files
			for object_layout_file in dict["object_layout_files"]:
				var object_layout_data = object_layout_loader.load_file(object_layout_file)
				$ObjectLayoutHandler.load_data(object_layout_data)
		
		$TileLayoutHandler.draw_layout($TileHandler, $BlockHandler, $ChunkHandler)
		
	

