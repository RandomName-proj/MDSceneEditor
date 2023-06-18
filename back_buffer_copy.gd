extends BackBufferCopy


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# TODO : understand how it actually works lmao
	var viewport_size := get_viewport_rect().size * 100 # dirty fix
	rect.size = viewport_size
	position = -viewport_size/2 + get_viewport().get_camera_2d().position 
