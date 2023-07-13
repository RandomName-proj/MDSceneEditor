extends RefCounted
class_name GenericFormatter

func get_base_format() -> BaseFormat:
	Global.console.printerr("This formatter is not implemented")
	return BaseFormat.new()

func format(data: PackedByteArray, required : Dictionary, parameters : Dictionary) -> BaseFormat:
	Global.console.printerr("This formatter is not implemented")
	return BaseFormat.new()

func deformat(data: BaseFormat, required : Dictionary, parameters : Dictionary) -> PackedByteArray:
	Global.console.printerr("This formatter is not implemented")
	return PackedByteArray()
