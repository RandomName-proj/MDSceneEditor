extends BaseFormat
class_name BaseArtFormat

func get_format():
	return "BaseArtFormat"

func merge(merge_data: BaseArtFormat):
	self.entries.append_array(merge_data.entries)
