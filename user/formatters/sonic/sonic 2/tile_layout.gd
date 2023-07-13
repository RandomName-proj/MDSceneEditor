extends GenericTileLayoutFormatter

const layout_size := Vector2i(128, 16)

func format(data: PackedByteArray, required : Dictionary, parameters : Dictionary) -> BaseFormat:
	var layout := BaseTileLayoutFormat.new()
	
	layout.layout_size = layout_size
	
	var offset := 0
	
	if (required["plane"] == "BG"):
		offset = 80
	
	for y in range(layout_size.y):
		for x in range(layout_size.x):
			layout.entries.append(BaseTileLayoutEntry.new(data[x+y*layout_size.x*2+offset]))
	
	#for ind in range(2, data.size()):
	#	layout.entries.append(BaseTileLayoutEntry.new(data[ind]))
	
	return layout

func deformat(data: BaseFormat, required : Dictionary, parameters : Dictionary) -> PackedByteArray:
	Global.console.printerr("This formatter is not implemented")
	return PackedByteArray()
