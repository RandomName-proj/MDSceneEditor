extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func draw():
	for child in get_children():
		if child is TilePlane:
			child.draw()

# Assigns planes' tilesets to planes' tilemaps 
func link_planes():
	for child in get_children():
		if child is TilePlane:
			child.link_tilemap(child.tilemap)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
