extends Node

var pal_line := 0

func _ready():
	$Sprite.material.set_shader_param("palette",PaletteHandler.pal_texture)
	$Sprite.position.x = get_viewport().size.x/2
	$Sprite.position.y = 128
	$Sprite.region_enabled = true
	$Sprite.region_rect = Rect2(0, 0, 64, 8)
	$Sprite.texture = MDVRAM.tex

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.material.set_shader_param("pal_line",pal_line)
	if Input.is_action_just_pressed("ui_chgpalline"):
		pal_line = (pal_line + 1) & 3
	if Input.is_action_just_pressed("ui_left"):
		$Sprite.region_rect.position.x -= 8
	if Input.is_action_just_pressed("ui_right"):
		$Sprite.region_rect.position.x += 8
