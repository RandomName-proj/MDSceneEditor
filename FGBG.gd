extends Node
class_name TilePlane

onready var tilemap := $TileMap

func get_handler(type):
	# find this handler in FG
	for child in get_children():
		if child is type:
			return child
	
	# else find this handle in TilePlanes
	for child in get_parent().get_children():
		if child is type:
			return child
	
	return null

func draw():
	get_handler(TileLayoutHandler).draw(self)
