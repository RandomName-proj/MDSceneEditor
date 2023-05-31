extends Node2D

var res_pool : MDResourcePool

func _ready():
	res_pool = $Resources # FFS this is the only way to enable syntax highlighting for preloaded nodes that use custom class
	res_pool.add_resource("vram")
	var vram : MDResource = res_pool.get_resource("vram")
	vram.load_format("res://user/formatters/Art.gd")
	vram.load_compression("res://user/compressors/nemesis.gd")
	vram.load_data("res://LZ.bin")
	$HardwareContainer/HardwareViewport/VRAM.load_vram(vram.data, 0)
	
	res_pool.add_resource("palette")
	var palette : MDResource = res_pool.get_resource("palette")
	palette.load_format("res://user/formatters/Palette.gd")
	palette.load_compression("res://user/compressors/uncompressed.gd")
	palette.load_data("res://palettes/preload.pal")
	
	#$HardwareContainer/HardwareViewport/BackBufferCopy/Paletter.material.set_shader_parameter("palette",palette.data.colors)
	
	res_pool.add_resource("lz_palette")
	var lz_palette : MDResource = res_pool.get_resource("lz_palette")
	lz_palette.load_format("res://user/formatters/Palette.gd")
	lz_palette.load_compression("res://user/compressors/uncompressed.gd")
	lz_palette.load_data("res://palettes/Sonic+LZ.pal")
	$HardwareContainer/HardwareViewport/BackBufferCopy/Paletter.material = load("res://palette_shader_material.tres").duplicate()
	print($HardwareContainer/HardwareViewport/BackBufferCopy/Paletter.material)
	$HardwareContainer/HardwareViewport/BackBufferCopy/Paletter.material.set_shader_parameter("palette",lz_palette.data.colors)
	
	res_pool.add_resource("underwater_palette")
	var underwater_palette : MDResource = res_pool.get_resource("underwater_palette")
	underwater_palette.load_format("res://user/formatters/Palette.gd")
	underwater_palette.load_compression("res://user/compressors/uncompressed.gd")
	underwater_palette.load_data("res://palettes/Sonic+LZ(Underwater).pal")
	$HardwareContainer/HardwareViewport/BackBufferCopy2/Wasser.material = load("res://palette_shader_material.tres").duplicate()
	$HardwareContainer/HardwareViewport/BackBufferCopy2/Wasser.material.set_shader_parameter("palette",underwater_palette.data.colors)
	
	


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
