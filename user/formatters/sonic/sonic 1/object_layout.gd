extends GenericObjectLayoutFormatter

func format(data: PackedByteArray, required : Dictionary, parameters : Dictionary) -> BaseFormat:
	var layout := BaseObjectLayoutFormat.new()
	
	for ind in range(0, data.size(), 6):
		
		var x_pos := (data[ind] << 8) + data[ind+1]
		var y_pos := ((data[ind+2] & 0b00111111) << 8) + data[ind+3]
		var flags := (data[ind+2] >> 6) & 0b11
		
		var id := data[ind+4] & 0x7F
		
		var additional : Dictionary
		additional["subtype"] = data[ind+5]
		
		var obj := BaseObjectLayoutEntry.new(id,x_pos,y_pos)
		obj.flags = flags
		obj.additional = additional
		
		layout.entries.append(obj)
		
	
	return layout

func deformat(data: BaseFormat, required : Dictionary, parameters : Dictionary) -> PackedByteArray:
	
	var raw_data := PackedByteArray()
	
	return raw_data
