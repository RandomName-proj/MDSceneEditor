extends Node

# References to child nodes

var vram_handler := VRAMHandler.new()
var palette_handler := PaletteHandler.new()
onready var pal_material : ShaderMaterial 
onready var pal_shader = preload("res://API/PalShader.gdshader")
onready var pal_material_tilemap : ShaderMaterial
onready var pal_shader_tilemap : Shader = preload("res://API/PalShaderTilemap.gdshader")

func _ready():
	pal_material = ShaderMaterial.new()
	pal_material.shader = pal_shader
	pal_material.set_shader_param("palette",palette_handler.texture)
	pal_material_tilemap = ShaderMaterial.new()
	pal_material_tilemap.shader = pal_shader_tilemap
	pal_material_tilemap.set_shader_param("palette",palette_handler.texture)

func load_parent_files(parents : Array, elements : Dictionary):
	for parent_path in parents:
		var file = File.new()
		file.open(parent_path, file.READ)
		var text = file.get_as_text()
		
		if parse_json(text) == null:
			print("Parent file wasn't found")
			return -1
		
		var json_dict : Dictionary = parse_json(text)
		
		file.close()
		
		if json_dict.has("parents"):
			load_parent_files(json_dict["parents"], elements)
		
		load_json_elements(json_dict, elements)
	

func load_json_elements(json_dict : Dictionary, elements : Dictionary):
	for key in json_dict:
		if not elements.has(key):
			elements[key] = []
		if json_dict[key] is Array:
			elements[key].append_array(json_dict[key])
		else:
			elements[key].append(json_dict[key])

func load_data(load_info, loader : Object, handler : Node):
	if load_info == null:
		print("Error: no load_info")
		return -1
	
	var data = handler.init_data(loader.get_init_args())
	
	var plane := ""
	
	if loader == null:
		print("Error: no loader")
		return -1
	
	print(load_info)
	
	for load_entry in load_info:
		if not load_entry.has("files"):
			print("Error: load_info doesn't have file field in it")
			return -1
		
		var offset : int = 0
		var length : int = 0
		
		# load length and destination offset is not in bytes, but in loader's units (chunks, blocks, etc.)
		
		if load_entry.has("dst_offset"):
			offset = load_entry["dst_offset"]
		
		if load_entry.has("load_len"):
			length = load_entry["load_len"]
		
		for path in load_entry["files"]:
			var file = File.new()
			var path_string : String
			
			if path is Array:
				path_string = path[0]
			else:
				path_string = path
			
			file.open(path_string,File.READ_WRITE)
			file.endian_swap = true
			
			if path is Array and path.size() > 1:
				file.seek(path[1])
				
			loader.load_file(file, data, load_entry, offset, length)
		
		
		handler.load_data(data, load_entry)
	

func load_file(path):
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	
	if parse_json(text) == null:
		return -1
	
	var json_dict : Dictionary = parse_json(text)
	file.close()
	
	var elements : Dictionary
	
	if json_dict.has("parents"):
		load_parent_files(json_dict["parents"], elements)
		elements.erase("parents")
	load_json_elements(json_dict, elements)
	
	
	var palette_loader : Script = load("res://Generic/Loaders/Palette.gd")
	var vram_loader : Script = load("res://Generic/Loaders/Art.gd")
	var block_loader : Script
	var chunk_loader : Script
	var tile_layout_loader : Script
	var object_layout_loader : Script
	
	if elements.has("default_loaders"):
		block_loader = load(elements["default_loaders"][0].blocks)
		chunk_loader = load(elements["default_loaders"][0].chunks)
		tile_layout_loader = load(elements["default_loaders"][0].tile_layout)
		object_layout_loader = load(elements["default_loaders"][0].object_layout)
	
	load_data(elements["palette"], palette_loader, palette_handler)
	load_data(elements["art"],vram_loader,vram_handler)
	load_data(elements["blocks"],block_loader,$BlockHandler)
	load_data(elements["chunks"],chunk_loader,$ChunkHandler)
	load_data(elements["tile_layout"],tile_layout_loader,$TileLayoutHandler)
	
	#if data.has("pal_files"):
	#	var cur_pal_offset : int = 0
	#	# TODO : implement proper loading of several palettes
	#	for pal_file in data["pal_files"]:
	#		cur_pal_offset = palette.load_file(pal_file, cur_pal_offset)
	#		
	
	#if data.has("art_files"):
	#	var cur_vram : int = 0 # current vram offset of loaded art
	#	
	#	for art_file in data["art_files"]:
	#		cur_vram = vram.load_file(art_file,cur_vram)
	#	
	
	#if data.has("loaders"):
	#	var block_loader : Script = load(data["loaders"][0].blocks)
	#	var chunk_loader : Script = load(data["loaders"][0].chunks)
	#	var tile_layout_loader : Script = load(data["loaders"][0].tile_layout)
	#	var object_layout_loader : Script = load(data["loaders"][0].object_layout)
	#	
	#	if data.has("block_files"):
	#		# TODO : implement proper loading of several block files
	#		for block_file in data["block_files"]:
	#			var block_data = block_loader.load_file(block_file)
	#			$BlockHandler.load_data(block_data[0])
	#			$TileHandler.load_data(block_data[1])
	#	
	#	if data.has("chunk_files"):
	#		# TODO : implement proper loading of several chunk files
	#		for chunk_file in data["chunk_files"]:
	#			var chunk_data = chunk_loader.load_file(chunk_file)
	#			$ChunkHandler.load_data(chunk_data)
	#	
	#	if data.has("tile_layout_files"):
	#		# TODO : implement proper loading of several tile layout files
	#		for tile_layout_files in data["tile_layout_files"]:
	#			var tile_layout_data = tile_layout_loader.load_file(tile_layout_files)
	#			$TileLayoutHandler.load_data(tile_layout_data)
	#	
	#	if data.has("object_layout_files"):
	#		# TODO : implement proper loading of several object layout files
	#		for object_layout_file in data["object_layout_files"]:
	#			var object_layout_data = object_layout_loader.load_file(object_layout_file)
	#			$ObjectLayoutHandler.load_data(object_layout_data)
	#	
	#	
	#	$TileLayoutHandler.draw_layout($TileHandler, $BlockHandler, $ChunkHandler)
		
	

