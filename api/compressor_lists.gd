extends Node

var _full_compressor_list : Dictionary
@onready var directory := "./user/"

func _ready():
	
	_full_compressor_list = JSON.parse_string(FileAccess.get_file_as_string(directory+"compressions.json"))
	
	for comp in _full_compressor_list:
		_full_compressor_list[comp] = FileHelper.format_filepath(_full_compressor_list[comp], directory)

func get_all_compressors() -> Dictionary:
	return _full_compressor_list

func get_compressor(compression : String) -> String:
	return _full_compressor_list[compression]
