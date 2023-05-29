extends RefCounted
class_name GenericFormatter

func format(data: PackedByteArray) -> BaseFormat:
	Global.console.printerr("This formatter is not implemented")
	return BaseFormat.new()

func deformat(data: BaseFormat) -> PackedByteArray:
	Global.console.printerr("This formatter is not implemented")
	return PackedByteArray()
