extends Node
class_name MDSpriteHelper

static func load_mapping(mapping: Array, base_offset : int, vram : Texture2D) -> Node2D:
	
	var map_node := Node2D.new()
	
	var spr_arr : Array[Node2D] = []
	
	for sprite in mapping:
		var spr := MDSpriteHelper.create_sprite(sprite.x_pos,sprite.y_pos,sprite.size,sprite.tile_offset+base_offset,sprite.flags,vram)
		spr_arr.append(spr)
	
	# children have to be added in reverse order because in mappings the first sprite is above next while in godot it's the opposite
	for i in range(len(spr_arr)-1,-1,-1):
		map_node.add_child(spr_arr[i])
	
	return map_node
	

static func create_sprite(x_pos: int, y_pos: int, size: int, tile_offset: int, flags: int, vram : Texture2D) -> Node2D:
	
	var spr_node := Node2D.new()
	
	var height := (size & 0b11) + 1
	var width := (size >> 2) + 1
	
	for x in range(width):
		for y in range(height):
			
			var cur_spr := Sprite2D.new()
			cur_spr.texture = vram
			cur_spr.position = Vector2i(x, y)*8+Vector2i(x_pos,y_pos)
			cur_spr.region_enabled = true
			cur_spr.region_rect = Rect2i(Vector2i(tile_offset+x*height+y,0)*8,Vector2i(8,8))
			cur_spr.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			cur_spr.centered = false
			
			spr_node.add_child(cur_spr)
			
	
	return spr_node
	
