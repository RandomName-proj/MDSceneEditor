extends GenericEventFormatter
# Pattern Load Cues

func format(data: PackedByteArray, required : Dictionary, parameters : Dictionary) -> BaseFormat:
	var plc := BaseEventFormat.new()
	
	var plc_length := (data[0] << 8) + data[1] + 1
	
	plc.entries.resize(plc_length)
	
	for i in range(plc_length):
		var gfx := (data[i * 6 + 2] << 24) + (data[i * 6 + 3] << 16) + (data[i * 6 + 4] << 8) + (data[i * 6 + 5]) # art pointer
		var vram_addr := (data[i * 6 + 6] << 8) + (data[i * 6 + 7]) # vram address
		plc.entries[i] = BaseEventEntry.new({"gfx": gfx, "vram": vram_addr})
	
	return plc

func deformat(data: BaseFormat, required : Dictionary, parameters : Dictionary) -> PackedByteArray:
	Global.console.printerr("This formatter is not implemented")
	return PackedByteArray()
