extends RefCounted
class_name BaseFormat

var parameters : Dictionary # additional non-required fields
var required : Dictionary # additional required fields
var entries : Array[BaseEntry] # the data itself

func merge(merge_data):
	Global.console.printerr("{format}: The format doesn't have its merge function implemented yet".format({"format":get_format()}))

func get_format():
	Global.console.printerr("The format is not defined")
	return "BaseFormat"

func get_required(field : String):
	if required.has(field):
		return required[field]
	else:
		Global.console.printerr("Field {field} wasn't found".format({"field": field}))
