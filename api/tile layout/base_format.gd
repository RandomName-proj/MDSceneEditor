extends BaseFormat
class_name BaseTileLayoutFormat

var layout_size : Vector2i

func _init():
	required["tile_set"] = null
	required["plane"] = null

func get_format():
	return "BaseTileLayoutFormat"

func merge(merge_data: BaseTileLayoutFormat):
	layout_size = merge_data.layout_size
	self.entries.append_array(merge_data.entries)
