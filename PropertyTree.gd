extends Tree


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var button_tex := preload("res://icon.png") # chunk button texture


# Called when the node enters the scene tree for the first time.
func _ready():
	var tile_plane := create_item() # create a tile plane section
	tile_plane.set_text(0,"Tile Plane") # set tile plane section text
	tile_plane.set_expand_right(0,true) # hide all collumns in tile plane section except collumn 0
	
	var name := create_item(tile_plane) # create a name property
	name.set_text(0,"Name") # set propety name
	name.set_text(1,"Foreground") # set property value
	name.set_editable(1,true) # make property value editable
	
	var chunks := create_item(tile_plane) # create chunks property
	chunks.set_text(0,"Chunks") # set property name
	chunks.set_cell_mode(1,TreeItem.CELL_MODE_CUSTOM) # set collumn 1 cell mode to custom to assign chunk editor node to it
	chunks.set_custom_draw(1,$ChunkEditor,"draw") # assign chunk editor node to collumn 1
	
	var palette := create_item(tile_plane) # create chunks property
	palette.set_text(0,"Palette") # set property name
	palette.set_cell_mode(1,TreeItem.CELL_MODE_CUSTOM) # set collumn 1 cell mode to custom to assign chunk editor node to it
	palette.set_custom_draw(1,$PaletteEditor,"draw") # assign chunk editor node to collumn 1
	
	var width := create_item(tile_plane) # create width property
	width.set_text(0,"Width") # set property name
	width.set_cell_mode(1,TreeItem.CELL_MODE_RANGE) # set collumn 1 cell mode to range for property value to be numerical
	width.set_editable(1,true) # make property value editable
	
	var height := create_item(tile_plane) # create height property
	height.set_text(0,"Height") # set property name
	height.set_cell_mode(1,TreeItem.CELL_MODE_RANGE) # set collumn 1 cell mode to range for property value to be numerical
	height.set_editable(1,true) # make property value editable


func _on_OpenProject_pressed():
	pass # Replace with function body.
