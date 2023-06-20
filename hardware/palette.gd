extends Node

@onready var material := preload("res://palette_shader_material.tres")

func load_palette(data : BasePaletteFormat):
	material.set_shader_parameter("palette",data.colors)
