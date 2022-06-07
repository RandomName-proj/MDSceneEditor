extends Node
class_name TileHandler

var tile_flip_arr : Array

func init_data(init_args : Dictionary):
	var data : Array
	
	for tile in range(0x800):
		data.append(DataFormats.Tile.new())
	
	return data

func load_data(data, load_entry):
	var tile_arr = data
	
	tile_flip_arr.clear()
	
	var tile_set := TileSet.new()
	$FG.clear()
	$BG.clear()
	
	for tile in tile_arr:
		var free_id = tile_set.get_last_unused_tile_id()
		
		tile_flip_arr.append([tile.flip_x, tile.flip_y])
		tile_set.create_tile(free_id) 
		tile_set.tile_set_texture(free_id, owner.vram_handler.texture)
		tile_set.tile_set_region(free_id, Rect2(tile.vram / 8, 0, 8, 8))
		tile_set.tile_set_modulate(free_id,Color(float(tile.palette)/4,0,0,0))
		tile_set.tile_set_material(free_id, owner.pal_material_tilemap)
	
	$FG.tile_set = tile_set
	$BG.tile_set = tile_set
	

func place_tile(x: int, y: int, id: int, plane, flip_x := false, flip_y := false):
		var plane_arr : Array
		
		if plane == "FG": 
			plane_arr = [$FG] 
		elif plane == "BG": 
			plane_arr = [$BG]
		else:
			plane_arr = [$FG, $BG]
		
		for pln in plane_arr:
			pln.set_cell(x, y, id, 
				int(flip_x)^int(tile_flip_arr[id][0]), int(flip_y)^int(tile_flip_arr[id][1]))
