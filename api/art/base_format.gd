extends BaseFormat
class_name BaseArtFormat

func _init():
	parameters["offset"] = null

func get_format():
	return "BaseArtFormat"

func merge(merge_data: BaseArtFormat):
	self.entries.append_array(merge_data.entries)
