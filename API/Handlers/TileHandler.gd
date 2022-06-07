extends Node


var tile_flip_arr : Array

func load_data(data):
	var tile_arr = data
	
	$FG.clear()
	$BG.clear()
	tile_flip_arr.clear()
	
	var tile_set := TileSet.new()
	
	
	for tile in tile_arr:
		var free_id = tile_set.get_last_unused_tile_id()
		
		tile_flip_arr.append([tile.flip_x, tile.flip_y])
		tile_set.create_tile(free_id) 
		tile_set.tile_set_texture(free_id, get_parent().vram.texture)
		tile_set.tile_set_region(free_id, Rect2(tile.vram / 8, 0, 8, 8))
		tile_set.tile_set_modulate(free_id,Color(float(tile.palette)/4,0,0,0))
		tile_set.tile_set_material(free_id, get_parent().pal_material_tilemap)
	
	$FG.tile_set = tile_set
	$BG.tile_set = tile_set
	

func place_tile(x: int, y: int, id: int, plane := "FG", flip_x := false, flip_y := false):
		var tile_map : Node
		
		if plane == "FG": 
			tile_map = $FG 
		elif plane == "BG": 
			tile_map = $BG 
		else:
			return -1
		
		tile_map.set_cell(x, y, id, 
			int(flip_x)^int(tile_flip_arr[id][0]), int(flip_y)^int(tile_flip_arr[id][1]))
