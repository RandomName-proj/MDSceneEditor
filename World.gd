extends Node2D

@onready var res_pool : MDResourcePool = $Resources
@onready var vram := $Hardware/VRAM
@onready var palette := $Hardware/Palette

func _ready():
	
	res_pool.add_resource("vram")
	var vram : MDResource = res_pool.get_resource("vram")
	vram.load_format("res://user/formatters/Art.gd")
	vram.load_compression("res://user/compressors/nemesis.gd")
	vram.load_data("res://test data/art/LZ.bin")
	$HardwareContainer/HardwareViewport/VRAM.load_vram(vram.data, 0)
	
	res_pool.add_resource("palette")
	var palette : MDResource = res_pool.get_resource("palette")
	palette.load_format("res://user/formatters/Palette.gd")
	palette.load_compression("res://user/compressors/uncompressed.gd")
	palette.load_data("res://test data/palettes/Sonic+LZ.pal")
	
	$HardwareContainer/HardwareViewport/BackBufferCopy/Paletter.material = load("res://palette_shader_material.tres")
	$HardwareContainer/HardwareViewport/BackBufferCopy/Paletter.material.set_shader_parameter("palette",palette.data.colors)
	
	res_pool.add_resource("blocks")
	var blocks : MDResource = res_pool.get_resource("blocks")
	blocks.load_format("res://user/formatters/Sonic/16x16 Blocks.gd")
	blocks.load_compression("res://user/compressors/enigma.gd")
	blocks.load_data("res://test data/blocks/LZ.bin")
	$HardwareContainer/HardwareViewport/Blocks.load_blocks(blocks.data)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir := Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	
	$HardwareContainer/HardwareViewport/Camera2D.position += dir*30
