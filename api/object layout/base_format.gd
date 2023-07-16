extends BaseFormat
class_name BaseObjectLayoutFormat

func _init():
	parameters["object_layer_script"] = null

func get_format():
	return "BaseObjectLayoutFormat"

func merge(merge_data: BaseObjectLayoutFormat):
	self.entries.append_array(merge_data.entries)
