extends BaseFormat
class_name BaseObjectMappingsFormat

func get_format():
	return "BaseObjectMappingsFormat"

func merge(merge_data: BaseObjectMappingsFormat):
	self.entries.append_array(merge_data.entries)
