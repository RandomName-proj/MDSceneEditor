extends Node
class_name MDSpriteHelper

static func load_mapping(mapping: Array, base_offset : int, flags: int, vram : Texture2D) -> Node2D:
	
	var map_node := Node2D.new()
	
	var spr_arr : Array[Node2D] = []
	
	var vram_offset := base_offset & 0xFFF
	
	var palette := (base_offset >> 13) & 3
	
	var x_flip := Bits.get_bits(flags,BaseObjectLayoutEntry.x_flip)
	var y_flip := Bits.get_bits(flags,BaseObjectLayoutEntry.y_flip)
	
	for sprite in mapping:
		
		var spr_height = (sprite.size & 0b11) + 1
		var spr_width = (sprite.size >> 2) + 1
		
		var spr_x : int
		var spr_y : int
		
		if x_flip:
			spr_x = -sprite.x_pos - (spr_width) * 8
		else:
			spr_x = sprite.x_pos
		
		if y_flip:
			spr_y = -sprite.y_pos - (spr_height) * 8
		else:
			spr_y = sprite.y_pos
		
		var spr_size = sprite.size
		var spr_tile = sprite.tile_offset+vram_offset
		var spr_pal = (palette+sprite.palette)&3
		var spr_flags = sprite.flags
		
		spr_flags = Bits.or_bits(spr_flags,x_flip,BaseObjectMappingsEntry.x_flip)
		spr_flags = Bits.or_bits(spr_flags,y_flip,BaseObjectMappingsEntry.y_flip)
		
		prints(x_flip, y_flip, spr_flags)
		
		var spr := MDSpriteHelper.create_sprite(spr_x,spr_y,spr_size,spr_tile,spr_pal,spr_flags,vram)
		spr_arr.append(spr)
	
	# children have to be added in reverse order because in mappings the first sprite is above next while in godot it's the opposite
	for i in range(len(spr_arr)-1,-1,-1):
		map_node.add_child(spr_arr[i])
	
	return map_node
	

static func create_sprite(x_pos: int, y_pos: int, size: int, tile_offset: int, palette : int, flags: int, vram : Texture2D) -> Node2D:
	
	var spr_node := Node2D.new()
	
	var height := (size & 0b11) + 1
	var width := (size >> 2) + 1
	
	var x_flip := Bits.get_bits(flags,BaseObjectMappingsEntry.x_flip)
	var y_flip := Bits.get_bits(flags,BaseObjectMappingsEntry.y_flip)
	
	for x in range(width):
		for y in range(height):
			
			var cur_spr := Sprite2D.new()
			cur_spr.texture = vram
			
			cur_spr.position = Vector2i(x_pos,y_pos)
			
			if x_flip:
				cur_spr.position.x += (width - 1 - x)*8
			else:
				cur_spr.position.x += x * 8
			
			if y_flip:
				cur_spr.position.y += (height - 1 - y) * 8 
			else:
				cur_spr.position.y += y * 8
			
			cur_spr.region_enabled = true
			cur_spr.region_rect = Rect2i(Vector2i(tile_offset+x*height+y,0)*8,Vector2i(8,8))
			cur_spr.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			cur_spr.centered = false
			cur_spr.flip_h = x_flip
			cur_spr.flip_v = y_flip
			
			cur_spr.modulate.g = (1 - 0.25*palette) # set palette
			
			spr_node.add_child(cur_spr)
			
	
	return spr_node
	
