extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_blocks(data: BaseBlockFormat):
	var source := TileSetAtlasSource.new()
	source.texture = get_parent().get_node("VRAM").texture
