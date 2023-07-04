extends RefCounted
class_name BaseFormat

var parameters : Dictionary # additional non-required fields
var required : Dictionary # additional required fields
var entries : Array[BaseEntry] # the data itself

func get_format():
	Global.console.printerr("This format is not defined")

func get_required(field : String):
	if required.has(field):
		return required[field]
	else:
		Global.console.printerr("Field {field} wasn't found".format({"field": field}))
