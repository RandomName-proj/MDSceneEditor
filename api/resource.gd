extends Node
class_name MDResource

var data : BaseFormat
var format : GenericFormatter
var compression : GenericCompressor
var filepath : String

func load_data(filepath: String):
	data = BaseFormat.new()
	
	var new_data := FileHelper.get_data_file(filepath)
	
	if new_data.is_empty():
		Global.console.printerr("[MDResource:'{name}']: Failed to get data".format({"name":self.name}))
		return
	
	new_data = compression.decompress(new_data) # takes a bit of time
	
	if new_data.is_empty():
		Global.console.printerr("[MDResource:'{name}']: Decompression failed".format({"name":self.name}))
		return
	
	var formatted_data := format.format(new_data) # formatting takes most of the time to process
	
	if formatted_data.entries.is_empty():
		Global.console.printerr("[MDResource:'{name}']: Formatting failed".format({"name":self.name}))
		return
	
	data = formatted_data # takes no time
	
	get_parent().emit_signal("resource_changed",self)
	

func load_format(filepath: String):
	format = FileHelper.get_format_file(filepath)
	if format == null:
		Global.console.printerr("[MDResource:'{name}']: Failed to load formatter at filepath: {filepath}".format({"name":self.name,"filepath":filepath}))
	else:
		get_parent().emit_signal("resource_changed",self)

func load_compression(filepath: String):
	compression = FileHelper.get_compressor_file(filepath)
	if compression == null:
		Global.console.printerr("[MDResource:'{name}']: Failed to load compressor at filepath: {filepath}".format({"name":self.name,"filepath":filepath}))
	else:
		get_parent().emit_signal("resource_changed",self)

func get_raw_data() -> PackedByteArray:
	var raw_data := format.deformat(data)
	
	if raw_data.is_empty():
		Global.console.printerr("[MDResource:'{name}']: Deformatting failed".format({"name":self.name}))
		return PackedByteArray()
	
	raw_data = compression.compress(raw_data)
	
	if raw_data.is_empty():
		Global.console.printerr("[MDResource:'{name}']: Compression failed".format({"name":self.name}))
		return PackedByteArray()
	
	return raw_data

func load_filepath(path: String):
	filepath = path

