extends GenericTileLayoutFormatter


func format(data: PackedByteArray, required : Dictionary, parameters : Dictionary) -> BaseFormat:
	var layout := BaseTileLayoutFormat.new()
	
	var layout_size := Vector2(data[0]+1,data[1]+1)
	layout.layout_size = layout_size
	for ind in range(0, layout_size.x*layout_size.y):
		layout.entries.append(BaseTileLayoutEntry.new(data[ind+2]))
	
	return layout

func deformat(data: BaseFormat, required : Dictionary, parameters : Dictionary) -> PackedByteArray:
	Global.console.printerr("This formatter is not implemented")
	return PackedByteArray()
