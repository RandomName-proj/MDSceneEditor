extends BaseEntry
class_name BaseObjectMappingsEntry

var maps : Array[Mapping]

class Mapping:
	func _init(x_pos : int, y_pos: int):
		self.x_pos = x_pos
		self.y_pos = y_pos
	
	var x_pos : int
	var y_pos : int
	var size : int
	var palette : int
	var flags : int
	var tile_offset : int = 0 # vram offset in tiles
	var additional : Dictionary
	

enum {x_flip = 0, y_flip}
