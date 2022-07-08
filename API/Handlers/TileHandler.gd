extends Node
class_name TileHandler

var tile_flip_arr : Array
var tile_set : TileSet

func load_data(data):
	owner = get_parent().owner # at least it works
	
	var tile_arr = data
	
	tile_flip_arr.clear()
	
	tile_set = TileSet.new()
	
	
	for tile in tile_arr:
		var free_id = tile_set.get_last_unused_tile_id()
		
		tile_flip_arr.append([tile.flip_x, tile.flip_y])
		tile_set.create_tile(free_id) 
		tile_set.tile_set_texture(free_id, owner.vram.texture)
		tile_set.tile_set_region(free_id, Rect2(tile.vram / 8, 0, 8, 8))
		tile_set.tile_set_modulate(free_id,Color(float(tile.palette)/4,0,0,0))
		tile_set.tile_set_material(free_id, owner.pal_material_tilemap)
	
	

func place_tile(x: int, y: int, id: int, plane, tilemap, flip_x := false, flip_y := false):
	tilemap.set_cell(x, y, id, 
		int(flip_x)^int(tile_flip_arr[id][0]), int(flip_y)^int(tile_flip_arr[id][1]))
