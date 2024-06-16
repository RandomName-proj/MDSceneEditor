extends Node

@onready var material := preload("res://palette_shader_material.tres").duplicate()

func load_palette(data : BasePaletteFormat):
	var color_arr := PackedColorArray()
	for entry in data.entries:
		color_arr.append(entry.color)
	material.set_shader_parameter("palette",color_arr)
