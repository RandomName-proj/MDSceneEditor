extends Node


func _ready():
	#add_child(artHandler)
	#MDVRAM.connect("Update",self,"_on_ArtHandler_Update")
	$Sprite.material.set_shader_param("palette",PaletteHandler.paltex)
	$Sprite.material.set_shader_param("palline",1)
	$Sprite.position.x = get_viewport().size.x/2
	$Sprite.position.y = 128
	$Sprite.region_enabled = true
	$Sprite.region_rect = Rect2(0, 0, 64, 8)
	$Sprite.texture = MDVRAM.tex
#	$Sprite.texture = PaletteHandler.paltex

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Sprite.texture = PaletteHandler.paltex
	pass

func _on_FileSelect_file_selected(path):
	MDVRAM.loadFile(path,0)
