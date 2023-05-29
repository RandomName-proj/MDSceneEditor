extends Node

var _full_compressor_list : Dictionary

func _ready():
	_full_compressor_list = JSON.parse_string(FileAccess.get_file_as_string("res://user/compressions.json"))

func get_all_compressors() -> Dictionary:
	return _full_compressor_list

func get_compressor(compression : String) -> String:
	return _full_compressor_list[compression]
