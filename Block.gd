extends Node

onready var pal_shader := preload("res://PalShader.gdshader")

var tiles_metadata : Array # each tile takes 2 bools: x flip and y flip


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Vector2) var grid_size = Vector2(8, 2) # grid size in riles

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_file(path):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	$TileMap.tile_set = TileSet.new()
	
	tiles_metadata.resize(0)
	
	# load all tiles from the file
	for tile in range(0, file.get_len()):
		var free_id = $TileMap.tile_set.get_last_unused_tile_id()
		
		var tile_data := file.get_16()
		var tile_vram := (tile_data & 0b11111111111) * 64 # tile's graphics vram position 
		var tile_region := Rect2(tile_vram / 8, 0, 8, 8)
		var tile_palette := (tile_data & 0b0110000000000000) >> 13
		var tile_material := ShaderMaterial.new()
		var tile_flip_x : bool = tile_data & 0b100000000000
		var tile_flip_y : bool = tile_data & 0b0001000000000000
		var tile_priority : bool = tile_data & 0b1000000000000000
		
		tiles_metadata.append([tile_flip_x, tile_flip_y, tile_priority])
		
		tile_material.shader = pal_shader
		tile_material.set_shader_param("palette",PaletteHandler.pal_texture)
		tile_material.set_shader_param("pal_line",tile_palette)
		
		$TileMap.tile_set.create_tile(free_id) 
		$TileMap.tile_set.tile_set_texture(free_id, MDVRAM.tex)
		$TileMap.tile_set.tile_set_region(free_id, tile_region)
		$TileMap.tile_set.tile_set_material(free_id, tile_material)
	
	
	

func place_block(x : int, y : int, id : int, flip_x := false, flip_y := false):
	for tile in range(0,4):
		var cur_tile := id*4 + tile
		var tile_x := x * 2 + abs(int(flip_x) - (tile & 1))
		var tile_y := y * 2 + abs(int(flip_y) - (tile / 2))
		$TileMap.set_cell(tile_x, tile_y, cur_tile, 
			tiles_metadata[cur_tile][0], tiles_metadata[cur_tile][1])
		
