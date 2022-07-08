extends Control
class_name UIChunk

onready var tilemap := MDTilemap.new()

func _init(chunk_size):
	rect_min_size = chunk_size
	size_flags_horizontal |= SIZE_SHRINK_CENTER
	size_flags_vertical |= SIZE_SHRINK_CENTER
	rect_clip_content = true


func _ready():
	add_child(tilemap)
