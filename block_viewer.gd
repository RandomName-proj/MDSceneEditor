extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	owner.connect("loaded_scene",_on_scene_loaded_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_scene_loaded_scene():
	for child in owner.block_sets.get_children():
		texture = child.get_tile_texture()
