extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level : Node

func md_color_to_rgb8(md_color: int) -> Color:
	var red = (md_color>>1)&0b111
	var green = (md_color>>(4+1))&0b111
	var blue = (md_color>>(8+1))&0b111
	red = level.palette.color_array[red]
	green = level.palette.color_array[green]
	blue = level.palette.color_array[blue]
	
	return Color8(red,green,blue)

func _init(level : Node):
	self.level = level

func load_file(path):
	var file := File.new()
	file.open(path,File.READ)
	file.endian_swap = true
	
	#var pal_end := min(64, file.get_len()/2 + offset) # color on which loading of this palette file ends
	var pal_arr : PoolColorArray
	
	#	Convert palette to RGB8
	for i in range(min(64,file.get_len()/2)):
		pal_arr.append(md_color_to_rgb8(file.get_16()))
	
	file.close()
	level.palette.load_data(pal_arr)
