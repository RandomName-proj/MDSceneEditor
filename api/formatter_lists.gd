extends Node

var _full_formatter_list : Dictionary

func _ready():
	_full_formatter_list = JSON.parse_string(FileAccess.get_file_as_string("res://user/formats.json"))

func get_formatter(game: String, res_type: String) -> String:
	return _full_formatter_list[game][res_type]

func get_resource_type_formatters(res_type: String) -> Dictionary:
	var form := Dictionary()
	for game in _full_formatter_list:
		if game.has(res_type):
			form[game] = form[game][res_type]
	
	return form

func get_game_formatters(game: String) -> Dictionary:
	return _full_formatter_list[game]

func get_all_games() -> Array:
	return _full_formatter_list.keys()