extends "res://user/formatters/sonic/blocks.gd"

const block_size := Vector2(2,2)

func format(data: PackedByteArray) -> BaseFormat:
	return _do_format(data, block_size)

func deformat(data: BaseFormat) -> PackedByteArray:
	return _do_deformat(data, block_size)
