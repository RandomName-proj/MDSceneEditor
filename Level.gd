extends Node2D

# References to child nodes

var vram := VRAMHandler.new()
var palette := PaletteHandler.new()
onready var pal_material : ShaderMaterial 
onready var pal_shader = preload("res://API/PalShader.gdshader")
onready var pal_material_tilemap : ShaderMaterial
onready var pal_shader_tilemap : Shader = preload("res://API/PalShaderTilemap.gdshader")
var chunk_id := 0

func _ready():
	add_child(vram)
	add_child(palette)
	pal_material = ShaderMaterial.new()
	pal_material.shader = pal_shader
	pal_material.set_shader_param("palette",palette.texture)
	pal_material_tilemap = ShaderMaterial.new()
	pal_material_tilemap.shader = pal_shader_tilemap
	pal_material_tilemap.set_shader_param("palette",palette.texture)

func load_parent_file(path, data):
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	
	if parse_json(text) == null:
		return -1
	
	var json_dict : Dictionary = parse_json(text)
	file.close()
	
	if json_dict.has("parent_file"):
		load_parent_file(json_dict["parent_file"], data)
	
	load_data(json_dict, data)
	

func _process(delta):
	#if Input.is_action_pressed("ui_mouse_left"):
	#	if $TilePlanes/FG.get_handler(ChunkHandler) != null:
	#		var chunk_pos : Vector2 = get_global_mouse_position() / $TilePlanes/FG.get_chunk_size()
	#		chunk_pos = Vector2(int(chunk_pos.x),int(chunk_pos.y))
	#		$TilePlanes/FG.set_chunk(chunk_pos.x, chunk_pos.y, chunk_id)
	#
	#if Input.is_action_pressed("ui_mouse_right"):
	#	if $TilePlanes/FG.get_handler(TileLayoutHandler) != null:
	#		var chunk_pos : Vector2 = get_global_mouse_position() / $TilePlanes/FG.get_chunk_size()
	#		chunk_pos = Vector2(int(chunk_pos.x),int(chunk_pos.y))
	#		chunk_id = $TilePlanes/FG.get_chunk(chunk_pos.x, chunk_pos.y)
	pass

func load_data(json_dict, data):
	for key in json_dict:
		if not data.has(key):
			data[key] = []
		if json_dict[key] is Array:
			for el in json_dict[key]:
				data[key].append(el)
		else:
			data[key].append(json_dict[key])

func load_file(path):
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	
	if parse_json(text) == null:
		return -1
	
	var json_dict : Dictionary = parse_json(text)
	file.close()
	
	var data : Dictionary
	
	if json_dict.has("parent_file"):
		load_parent_file(json_dict["parent_file"], data)
	load_data(json_dict, data)
	
	vram.clear()
	
	
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
	
	if data.has("loaders"):
		
		var loaders : Dictionary
		var level_data : Dictionary
		
		
		for loader_type in data["loaders"][0]:
			var loader_node = load(data["loaders"][0][loader_type])
			loaders[loader_type] = loader_node.new(self)
		
		if data.has("art_files"):
			# TODO : implement proper loading of several art files
			for art_file in data["art_files"]:
				level_data["art"] = loaders["art"].load_file(art_file)
		
		if data.has("pal_files"):
			# TODO : implement proper loading of several palette files
			for pal_file in data["pal_files"]:
				level_data["palette"] = loaders["palette"].load_file(pal_file)
		
		if data.has("block_files"):
			# TODO : implement proper loading of several block files
			for block_file in data["block_files"]:
				level_data["blocks"] = loaders["blocks"].load_file(block_file)
		
		if data.has("chunk_files"):
			# TODO : implement proper loading of several chunk files
			for chunk_file in data["chunk_files"]:
				level_data["chunks"] = loaders["chunks"].load_file(chunk_file)
		
		if data.has("tile_layout_files"):
			# TODO : implement proper loading of several tile layout files
			for tile_layout_files in data["tile_layout_files"]:
				level_data["tile_layout"] = loaders["tile_layout"].load_file(tile_layout_files)
		
		$TilePlanes.link_planes()
		$TilePlanes.draw()
		
		#if data.has("object_layout_files"):
		#	# TODO : implement proper loading of several object layout files
		#	for object_layout_file in data["object_layout_files"]:
		#		level_data["object_layout"] = loaders["object_layout"].load_file(object_layout_file)
		
		
		#$TilePlanes.load_planes(level_data)
		
	

