extends BaseEntry
class_name BaseObjectMappingsEntry

var maps : Array[Mapping]

class Mapping:
	func _init(x_pos : int, y_pos: int):
		self.x_pos = x_pos
		self.y_pos = y_pos
	
	var x_pos : int
	var y_pos : int
	var width : int
	var height : int
	var flags : int
	var additional : Dictionary
