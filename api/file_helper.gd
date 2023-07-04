extends Node
class_name FileHelper

static func _check_file(file: FileAccess, filepath : String):
	if (file == null) or not file.is_open():
		Global.console.printerr("Can't open file at filepath: {filepath}".format({"filepath":filepath}))
		return false
	else:
		return true

# translates project's filepath into godot's filepath
static func format_filepath(filepath : String):
	return filepath

static func open_file(filepath : String):
	pass

static func get_data_file(filepath: String) -> PackedByteArray:
	filepath = format_filepath(filepath)
	if _check_file(FileAccess.open(filepath,FileAccess.READ), filepath):
		return FileAccess.get_file_as_bytes(filepath)
	else:
		return PackedByteArray()

static func get_format_file(filepath: String) -> GenericFormatter:
	filepath = format_filepath(filepath)
	if _check_file(FileAccess.open(filepath,FileAccess.READ), filepath):
		var formatter := GenericFormatter.new()
		formatter.script = load(filepath)
		return formatter
	else:
		return


static func get_compressor_file(filepath: String) -> GenericCompressor:
	filepath = format_filepath(filepath)
	if _check_file(FileAccess.open(filepath,FileAccess.READ), filepath):
		var compressor := GenericCompressor.new()
		compressor.script = load(filepath)
		return compressor
	else:
		return
