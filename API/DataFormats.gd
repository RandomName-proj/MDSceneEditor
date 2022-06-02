extends Node

class Tile:
	var vram : int # vram index
	var palette : int
	var priority : bool
	var flip_x : bool
	var flip_y : bool
	

class Block:
	var size : Vector2
	var tile_indexes : Array
	
	func _init(size):
		self.size = size
		for tile in range(0,size.x*size.y):
			tile_indexes.append(0)
	

class Chunk:
	var block_ids : Array
	var block_flips : Array
	var block_solids : Array
	var size : Vector2
	
	func _init(size):
		self.size = size
		for _i in range(0,size.x*size.y):
			block_ids.append(0)
			block_flips.append([0,0])
			block_solids.append(0)
	

class Level_Object:
	var pos : Vector2
	var id
	var subtype
	var flip_x : bool 
	var flip_y : bool
	
