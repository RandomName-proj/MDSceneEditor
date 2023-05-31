extends BaseFormat
class_name BasePaletteFormat

const accurate_color_array : PackedByteArray = [0, 52, 87, 116, 144, 172, 206, 255]
const linear_color_array : PackedByteArray = [0, 34, 68, 102, 136, 170, 204, 238]

var color_array := linear_color_array

var colors := PackedColorArray()

#const palette_length := 64

#var texture := ImageTexture.create_from_image(Image.create(palette_length,1,false,Image.FORMAT_RGBAF))

func _init():
	entries.append(BasePaletteEntry.new()) # idfk how but it doesn't work without this
