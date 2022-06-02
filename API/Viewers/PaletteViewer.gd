extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var pal_entry_size: Vector2 = Vector2(16,16)

# Called when the node enters the scene tree for the first time.
func _ready():
	var img := Image.new()
	var tex := ImageTexture.new()
	
	img.create(4,16,false,Image.FORMAT_RGBAF)
	img.lock()
	
	for row in range(16):
		for col in range(4):
			img.set_pixel(col, row, Color8((col * 16 + row)*4,0,0)) # pre-multiply by 4 to optimize shader
	
	img.unlock()
	tex.create_from_image(img,0)
	
	$Sprite.texture = tex
	$Sprite.modulate = Color.black
	$Sprite.scale = pal_entry_size
	$Sprite.position = Vector2(pal_entry_size.x*4/2,pal_entry_size.y*16/2)




func _on_World_changed_level(selected_level):
	$Sprite.material = selected_level.pal_material
