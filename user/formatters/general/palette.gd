extends GenericPaletteFormatter

func md_color_to_rgb8(md_color: int, color_array : PackedByteArray) -> Color:
	var red = (md_color>>1)&0b111
	var green = (md_color>>(4+1))&0b111
	var blue = (md_color>>(8+1))&0b111
	red = color_array[red]
	green = color_array[green]
	blue = color_array[blue]
	
	return Color8(red,green,blue)

func format(data: PackedByteArray, required : Dictionary, parameters : Dictionary) -> BaseFormat:
	var palette := BasePaletteFormat.new()
	
	
	for ind in range(0, data.size(), 2):
		var entry = (data[ind] << 8) + data[ind+1]
		var color := BasePaletteEntry.new(md_color_to_rgb8(entry, palette.color_array))
		palette.entries.append(color)
	
	
	return palette

func deformat(data: BaseFormat, required : Dictionary, parameters : Dictionary) -> PackedByteArray:
	var raw_data = PackedByteArray()
	
	Global.console.printerr("I'll implement it later [GenericPaletteFormatter]")
	
	return raw_data

