extends Node
class_name FileHelper

static func _check_file(file: FileAccess, filepath : String):
	if (file == null) or not file.is_open():
		Global.console.printerr("Can't open file at filepath: {filepath}".format({"filepath":filepath}))
		return false
	else:
		return true

# translates project's filepath into godot's filepath
static func format_filepath(filepath : String): # TODO: recall why it is even needed lol
	return filepath

static func get_data_file(filepath: String, start: int, end: int, step: int, mdse_scene : MDSEScene) -> PackedByteArray:
	
	if filepath.ends_with(":"):
		var asm_path := filepath.erase(filepath.length()-1)
		
		if asm_path.is_valid_int():
			return mdse_scene.asm_handler.get_rom().slice(int(asm_path))
		else:
			return mdse_scene.asm_handler.get_label_data(asm_path)
	
	filepath = format_filepath(filepath)
	if _check_file(FileAccess.open(filepath,FileAccess.READ), filepath):
		var data := FileAccess.get_file_as_bytes(filepath)
		if step != 0:
			var offsetted_data := PackedByteArray()
			if end == 0:
				end = data.size()
			for i in range(start, end, step):
				offsetted_data.append(data[i])
			return offsetted_data
		else: # if step equals to 0 just load the file
			return data
	else:
		return PackedByteArray()

static func get_format_file(filepath: String) -> GenericFormatter:
	if not(filepath.contains("/") or filepath.contains("\\")):
		filepath = get_format_template(filepath)
	
	filepath = format_filepath(filepath)
	if _check_file(FileAccess.open(filepath,FileAccess.READ), filepath):
		var formatter := GenericFormatter.new()
		formatter.script = load(filepath)
		return formatter
	else:
		return

static func get_format_template(filepath: String) -> String:
	var game := filepath.get_slice(".", 0)
	var res_type := filepath.get_slice(".", 1)
	return FormatterLists.get_formatter(game, res_type)

static func get_compressor_file(filepath: String) -> GenericCompressor:
	if not(filepath.contains("/") or filepath.contains("\\")):
		filepath = get_compressor_template(filepath)
	filepath = format_filepath(filepath)
	if _check_file(FileAccess.open(filepath,FileAccess.READ), filepath):
		var compressor := GenericCompressor.new()
		compressor.script = load(filepath)
		return compressor
	else:
		return

static func get_compressor_template(filepath: String) -> String:
	return CompressorLists.get_compressor(filepath)
