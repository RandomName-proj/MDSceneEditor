extends Node
class_name ASMHandler # currently supports only ASM68K

var rom_data : PackedByteArray
var label_data : Dictionary # key - label name, value - offset

func load_labels(rom_arr: PackedByteArray, label_text : String):
	
	
	rom_data = rom_arr
	
	var cur_label := ""
	var cur_line_num := 0
	
	for line in label_text.split("\n"):
		
		
		var line_words : PackedStringArray
		
		
		if line.length() < 37:
			continue
		
		
		# [ASM68K .lst]
		# 1) "equ" and "=" are used in equates ("=" also shows up in the listing data for the equates) but not in labels; "macro" and "macros" are used only in macros
		# 2) if a line has a label the label always starts at the 37th symbol (= check is needed because for equates = is the first symbol in the second word)
		if ":equ" not in line and " equ" not in line and "\tequ" not in line and "=" not in line and ":macro" not in line and " macro" not in line and "\tmacro" not in line \
		and line[36] not in "0123456789;= \t\r\n": 
			cur_label = ""
			
			# first 36 symbols int the line are listing data
			for i in range(36, line.length()):
				if line[i] in " \t\r\n:":
					break
				else:
					cur_label += line[i]
			
			cur_line_num = line.left(8).hex_to_int() 
			
			label_data[cur_label] = cur_line_num
			
		
	
	

func get_label_offset(label: String):
	return label_data[label]

func get_label_data(label: String):
	return rom_data.slice(label_data[label]) # that's a pretty slow way of getting data from asm but it'll work for now

func get_rom():
	return rom_data
