extends BaseFormat
class_name BaseBlockFormat

var tile_size : Vector2i

func _init():
	required["art"] = null

func get_format():
	return "BaseBlockFormat"

func merge(merge_data: BaseBlockFormat):
	tile_size = merge_data.tile_size
	self.entries.append_array(merge_data.entries)
