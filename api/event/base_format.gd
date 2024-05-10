extends BaseFormat
class_name BaseEventFormat

func _init():
	required["script"] = null

func get_format():
	return "BaseEventFormat"

func merge(merge_data: BaseEventFormat):
	self.entries.append_array(merge_data.entries)
