extends GenericArtFormatter

func format(data: PackedByteArray) -> BaseFormat:
	var art := BaseArtFormat.new()
	
	for byte in data:
		var color1 = byte >> 4
		var color2 = byte & 0xF
		art.entries.append(BaseArtEntry.new(Color8(color2,0,0)))
		art.entries.append(BaseArtEntry.new(Color8(color1,0,0)))
	
	return art

func deformat(data: BaseFormat) -> PackedByteArray:
	var raw_data = PackedByteArray()
	
	for ind in range(0, data.size(),2):
		var color1 = data.entries[ind].color.a8
		var color2 = data.entries[ind+1].color.a8
		raw_data.append((color1 << 4) + color2)
	
	return raw_data

