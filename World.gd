extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.root = self
	$Chunk.block_node = $Block
	PaletteHandler.load_file("Palettes/standart.pal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_data(jsonFile : String):
	var file = File.new()
	file.open(jsonFile, file.READ)
	var text = file.get_as_text()
	
	if parse_json(text) == null:
		return -1
	
	var dict : Dictionary = parse_json(text)
	file.close()
	
	if dict.has("pal_files"):
		# TODO : implement proper loading of several palettes
		for pal_file in dict["pal_files"]:
			PaletteHandler.load_file(pal_file)
			
	
	if dict.has("art_files"):
		var cur_vram : int = 0 # current vram offset of loaded art
		
		for art_file in dict["art_files"]:
			cur_vram = MDVRAM.load_file(art_file,cur_vram)
		
	
	if dict.has("block_files"):
		# TODO : implement proper loading of several block files
		for block_file in dict["block_files"]:
			$Block.load_file(block_file)
	
	if dict.has("chunk_files"):
		# TODO : implement proper loading of several chunk files
		for chunk_file in dict["chunk_files"]:
			$Chunk.load_file(chunk_file)
	
