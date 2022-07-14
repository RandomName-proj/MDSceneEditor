extends Node
class_name Palette

var texture := ImageTexture.new()
const accurate_color_array : Array = [0, 52, 87, 116, 144, 172, 206, 255]
const linear_color_array : Array = [0, 34, 68, 102, 136, 170, 204, 238]
var color_array : Array = [] setget set_color_arr

func md_color_to_rgb8(md_color: int) -> Color:
	var red = (md_color>>1)&0b111
	var green = (md_color>>(4+1))&0b111
	var blue = (md_color>>(8+1))&0b111
	red = color_array[red]
	green = color_array[green]
	blue = color_array[blue]
	
	return Color8(red,green,blue)

func set_color_arr(new_color):
	if color_array == null:
		color_array = new_color
	elif new_color == color_array:
		return
	else:
		for pal_ind in range(64):
			var r = new_color[color_array.find(get_palette_entry(pal_ind).r8)]
			var g = new_color[color_array.find(get_palette_entry(pal_ind).g8)]
			var b = new_color[color_array.find(get_palette_entry(pal_ind).b8)]
			set_palette_entry(Color8(r,g,b),pal_ind)
		color_array = new_color

func _init():
	color_array = linear_color_array
	var img := Image.new()
	img.create(64,1,false,Image.FORMAT_RGB8)
	img.lock()
	
	for color in range(64):
		img.set_pixel(color,0,Color.white)
	
	img.unlock()
	texture.create_from_image(img,0)

func _process(delta):
	if Global.settings["accurate_palette"] == true:
		self.color_array = accurate_color_array
	elif Global.settings["accurate_palette"] == false:
		self.color_array = linear_color_array

func get_palette_entry(pal_ind : int):
	var img := texture.get_data()
	img.lock()
	return img.get_pixel(pal_ind,0)

func set_palette_entry(color : Color, pal_ind : int):
	var img := texture.get_data()
	img.lock()
	img.set_pixel(pal_ind,0,color)
	img.unlock()
	texture.set_data(img)

func load_file(path, offset):
	
	var file = File.new()
	file.open(path,File.READ_WRITE)
	file.endian_swap = true
	
	var pal_end := min(64, file.get_len()/2 + offset) # color on which loading of this palette file ends
	
	#	Convert palette to RGB8
	for i in range(min(64,file.get_len()/2)):
		set_palette_entry(md_color_to_rgb8(file.get_16()), i + offset)
	
	
	file.close()
	return pal_end
