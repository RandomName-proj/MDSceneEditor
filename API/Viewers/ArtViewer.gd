extends Node2D

var pal_line := 0
var cur_level

func _ready():
	$Sprite.position.x = get_viewport().size.x/2
	$Sprite.position.y = 128
	$Sprite.region_enabled = true
	$Sprite.region_rect = Rect2(0, 0, 64, 8)
	$Sprite.modulate = Color.transparent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Sprite.modulate = Color(float(pal_line)/4, 0, 0, 1)
	if Input.is_action_just_pressed("ui_chgpalline"):
		pal_line = wrapi(pal_line+1,0,4)
	
	#if Input.is_action_just_pressed("ui_left"):
	#	$Sprite.region_rect.position.x -= 8
	#if Input.is_action_just_pressed("ui_right"):
	#	$Sprite.region_rect.position.x += 8
	pass


func _on_World_changed_level(selected_level):
	$Sprite.material = selected_level.pal_material
	$Sprite.texture = selected_level.vram.texture
