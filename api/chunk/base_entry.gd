extends BaseEntry
class_name BaseChunkEntry

func _init(chunk_size : Vector2, solid_layers : int):
	blocks.resize(chunk_size.x*chunk_size.y)
	var null_block := Block.new()
	null_block.solids.resize(solid_layers)
	null_block.solids.fill(0)
	blocks.fill(null_block)

var blocks : Array[Block]

class Block:
	
	var index : int = 0 # index in block array
	
	var flags : int = 0
	enum {x_bit = 0, y_bit}
	
	
	# each byte is a separate collision layer
	# 0 - not solid, 1 - top solid, 2 - left/right/bottom solid, and 3 - all solid
	var solids : PackedByteArray = [0]
