extends Node

func load_file(path):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	
	var object_arr : Array
	
	while file.get_position() < file.get_len():
		var obj := DataFormats.Level_Object.new() 
		var object_data = file.get_buffer(6) 
		
		obj.pos.x = (object_data[0] << 8) + object_data[1]
		obj.pos.y = ((object_data[2] & 0b111111) << 8) + object_data[3]
		obj.id = object_data[4] & 127
		obj.subtype = object_data[5]
		
		object_arr.append(obj)
		
	
	return object_arr
