extends Node
class_name MDResource

var data : BaseFormat
var format : GenericFormatter
var compression : GenericCompressor
var filepath

func load_data(filepath):
	
	var filepath_arr : Array
	
	if filepath is String:
		filepath_arr.append([filepath,0,0,0])
	elif filepath is Array:
		for entry in filepath:
			if entry is String:
				filepath_arr.append([entry,0,0,0])
			elif entry is Array:
				pass
	else:
		Global.console.printerr("[MDResource:'{name}']: Filepath {filepath} has incorrect type".format({"filepath":filepath,"type":filepath.get_class()}))
	
	
	for path in filepath_arr:
		
		
		var new_data := FileHelper.get_data_file(path[0], path[1], path[2], path[3], owner)
		
		if new_data.is_empty():
			Global.console.printerr("[MDResource:'{name}']: Failed to get data".format({"name":self.name}))
			return
		
		new_data = compression.decompress(new_data) # takes a bit of time
		
		if new_data.is_empty():
			Global.console.printerr("[MDResource:'{name}']: Decompression failed".format({"name":self.name}))
			return
		
		var formatted_data := format.format(new_data, data.required, data.parameters) # formatting takes most of the time to process
		formatted_data.required = data.required
		formatted_data.parameters = data.parameters
		
		if formatted_data.entries.is_empty():
			Global.console.printerr("[MDResource:'{name}']: Formatting failed".format({"name":self.name}))
			return
		
		data.merge(formatted_data)
		
		
	

func load_format(filepath: String) -> bool:
	format = FileHelper.get_format_file(filepath)
	if format == null:
		Global.console.printerr("[MDResource:'{name}']: Failed to load formatter at filepath: {filepath}".format({"name":self.name,"filepath":filepath}))
		return false
	
	data = format.get_base_format()
	
	return true

func load_compression(filepath: String) -> bool:
	compression = FileHelper.get_compressor_file(filepath)
	if compression == null:
		Global.console.printerr("[MDResource:'{name}']: Failed to load compressor at filepath: {filepath}".format({"name":self.name,"filepath":filepath}))
		return false
	
	return true

func get_raw_data() -> PackedByteArray:
	var raw_data := format.deformat(data, data.required, data.parameters)
	
	if raw_data.is_empty():
		Global.console.printerr("[MDResource:'{name}']: Deformatting failed".format({"name":self.name}))
		return PackedByteArray()
	
	raw_data = compression.compress(raw_data)
	
	if raw_data.is_empty():
		Global.console.printerr("[MDResource:'{name}']: Compression failed".format({"name":self.name}))
		return PackedByteArray()
	
	return raw_data

func load_filepath(path):
	filepath = path

