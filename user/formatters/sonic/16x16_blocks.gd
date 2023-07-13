extends "res://user/formatters/sonic/blocks.gd"

const block_size := Vector2(2,2)

func format(data: PackedByteArray, required : Dictionary, parameters : Dictionary) -> BaseFormat:
	return _do_format(data, block_size)

func deformat(data: BaseFormat, required : Dictionary, parameters : Dictionary) -> PackedByteArray:
	return _do_deformat(data, block_size)
