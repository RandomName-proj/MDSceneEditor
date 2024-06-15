extends Node
class_name Num

static func to_int(val : String) -> int:
	if val.begins_with("0x"):
		if val.right(val.length()-2).is_valid_hex_number():
			return val.hex_to_int()
		else:
			Global.console.printerr("Incorrect hex number!")
	elif val.begins_with("0b"):
		if val.right(val.length()-2).is_valid_int():
			return val.bin_to_int()
		else:
			Global.console.printerr("Incorrect binary number!")
	else:
		if val.is_valid_int():
			return val.to_int()
		else:
			Global.console.printerr("Incorrect decimal number!")
	
	return 0
	
