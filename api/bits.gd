extends Node
class_name Bits

# bit is indexed from 0 and bit signifies the most significant bit in the sequence
static func get_bits(val : int, bit : int = 0, count : int = 1) -> int:
	
	if (bit + 1 - count) < 0:
		Global.console.printerr("Impossible bit sequence!")
		return 0
	
	return (val & ((1 << count) - 1 << bit)) >> bit + 1 - count

static func set_bits(val : int, chg : int, bit : int = 0, count : int = 1) -> int:
	
	if (bit + 1 - count) < 0:
		Global.console.printerr("Impossible bit sequence!")
	
	val &= ~(((1 << count) - 1 << bit) >> bit + 1 - count)
	val |= chg << bit + 1 - count
	
	return val
	

static func or_bits(val : int, chg : int, bit : int = 0, count : int = 1) -> int:
	
	if (bit + 1 - count) < 0:
		Global.console.printerr("Impossible bit sequence!")
	
	val |= chg << bit + 1 - count
	
	return val
	
