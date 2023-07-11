extends BaseFormat
class_name BaseChunkFormat

var tile_size : Vector2i

func _init():
	required["art"] = null

func get_format():
	return "BaseChunkFormat"

func merge(merge_data: BaseChunkFormat):
	tile_size = merge_data.tile_size
	self.entries.append_array(merge_data.entries)
