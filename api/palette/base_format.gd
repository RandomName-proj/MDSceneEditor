extends BaseFormat
class_name BasePaletteFormat

const accurate_color_array : PackedByteArray = [0, 52, 87, 116, 144, 172, 206, 255]
const linear_color_array : PackedByteArray = [0, 34, 68, 102, 136, 170, 204, 238]

var color_array := linear_color_array

func get_format():
	return "BasePaletteFormat"

func merge(merge_data: BasePaletteFormat):
	self.entries.append_array(merge_data.entries)
