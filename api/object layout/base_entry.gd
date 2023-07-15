extends BaseEntry
class_name BaseObjectLayoutEntry

func _init(id, x_pos : int, y_pos: int):
	self.id = id
	self.x_pos = x_pos
	self.y_pos = y_pos

var id
var x_pos : int
var y_pos : int
var flags : int
var additional : Dictionary
