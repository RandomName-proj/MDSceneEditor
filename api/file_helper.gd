extends Node
class_name FileHelper

static func _check_file(file: FileAccess, filepath : String):
	if (file == null) or not file.is_open():
		Global.console.printerr("Can't open file at filepath: {filepath}".format({"filepath":filepath}))
		return false
	else:
		return true

static func get_data_file(filepath: String) -> PackedByteArray:
	if _check_file(FileAccess.open(filepath,FileAccess.READ), filepath):
		return FileAccess.get_file_as_bytes(filepath)
	else:
		return PackedByteArray()

static func get_format_file(filepath: String) -> GenericFormatter:
	if _check_file(FileAccess.open(filepath,FileAccess.READ), filepath):
		var formatter := GenericFormatter.new()
		formatter.script = load(filepath)
		return formatter
	else:
		return


static func get_compressor_file(filepath: String) -> GenericCompressor:
	if _check_file(FileAccess.open(filepath,FileAccess.READ), filepath):
		var compressor := GenericCompressor.new()
		compressor.script = load(filepath)
		return compressor
	else:
		return
