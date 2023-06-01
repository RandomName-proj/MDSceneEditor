extends GenericTileLayoutFormatter


func format(data: PackedByteArray) -> BaseFormat:
	var layout := BaseTileLayoutFormat.new()
	
	var layout_size := Vector2(data[0]+1,data[1]+1)
	layout.layout_size = layout_size
	for ind in range(2, data.size()):
		layout.entries.append(BaseTileLayoutEntry.new(data[ind]))
	
	return layout

func deformat(data: BaseFormat) -> PackedByteArray:
	Global.console.printerr("This formatter is not implemented")
	return PackedByteArray()
