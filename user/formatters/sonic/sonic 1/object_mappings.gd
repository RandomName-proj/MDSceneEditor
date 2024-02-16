extends GenericObjectMappingsFormatter

func format(data: PackedByteArray, required : Dictionary, parameters : Dictionary) -> BaseFormat:
	
	var mappings := BaseObjectMappingsFormat.new()
	
	var frame_offset : Array
	
	frame_offset.resize(1)
	
	var min_offset := ((data[0] << 8) + data[1])
	
	frame_offset[0] = min_offset
	
	var frame_ind := 2
	
	while frame_ind < min_offset:
		
		var cur_offset := ((data[frame_ind] << 8) + data[frame_ind + 1])
		
		min_offset = min(min_offset, cur_offset)
		
		frame_offset.append(cur_offset)
		
		frame_ind += 2
		
	
	
	
	for map_ind in frame_offset:
		
		var map := BaseObjectMappingsEntry.new()
		
		var map_count := data[map_ind] # mapping count
		
		var map_size := 5 # size of each mapping
		
		map.maps.resize(map_count) 
		
		for i in range(map_ind + 1, map_ind + 1 + map_size * map_count, map_size):
			
			var x_pos := data[i + 4]
			var y_pos := data[i]
			
			var width := data[i + 1]
			
			var tile_offset := (data[i + 2] & 0b00000111 << 8) + data[i + 3]
			
			var flags := data[i + 2] & 0b11111000
			
			var entr := BaseObjectMappingsEntry.Mapping.new(x_pos, y_pos)
			
			
		
		mappings.entries.append(map)
		
	
	return mappings

func deformat(data: BaseFormat, required : Dictionary, parameters : Dictionary) -> PackedByteArray:
	
	var raw_data := PackedByteArray()
	
	return raw_data
