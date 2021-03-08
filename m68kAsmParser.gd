extends Resource
class_name m68kAsmParser

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var parsingLines: PoolStringArray
var curTextPos:= Vector2(0,0)
var cmdStartPos:= Vector2(0,0)
var cmd:= ""
var cmdSize:= ""
var rsCounter = 0
var rawData : PoolByteArray

const stopSymbols: = "\t\n " # symbols where each command ends
const gapSymbols: = "\t\n " # symbols which end commands, but are not part of them

# Name, size in bytes
enum DataSizes {
	EMPTY = 0
	BYTE = 1,
	WORD = 2,
	TRIPLE_BYTE = 3,
	DOUBLE_WORD = 4,
	FIVE_BYTES = 5,
	QUAD_WORD = 8
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func parse(text: String):
	cmdStartPos = Vector2(0,0)
	curTextPos = Vector2(0,0)
	cmd = ""
	cmdSize = ""
	rawData = []
	parsingLines = text.split("\n")
#	print(parsingLines)
	_executeLine()
	return rawData

func _executeLine():
	_getNextCommand()
	_executeCommand()
	print(parsingLines[0])
	print(cmd)
	print(cmdSize)

func _getNextCommand():
	
	
	var tempPos = curTextPos
	while(true):
		tempPos = curTextPos
		for i in gapSymbols:
			if (parsingLines[curTextPos.y].substr(curTextPos.x,1) == i):
				curTextPos.x += 1
		
		if (tempPos == curTextPos): break
	
#	print(parsingLines[curTextPos.y].substr(curTextPos.x,1))
	
	cmdStartPos = curTextPos
	
	cmd = parsingLines[cmdStartPos.y].right(cmdStartPos.x)
	
	var tempCmd = cmd.right(max(cmd.find("."),0))
	
	for i in stopSymbols:
		if (tempCmd.find(i) != -1):
				cmd = cmd.substr(cmdStartPos.x-1,tempCmd.find(i)+max(cmd.find("."),0)-cmdStartPos.x+1)
	
	curTextPos.x += cmd.length()
	
	if (cmd.find(".") != -1):
		cmdSize = cmd.right(cmd.find("."))
		cmd = cmd.left(cmd.find("."))
	else:
		cmdSize = ""
	
	cmd = cmd.strip_edges()
	cmdSize = cmdSize.strip_edges()
	cmdSize.erase(0,1)

func _executeCommand():
	match cmd:
		"dc":
			_executeDC()
		"rs":
			_executeRS()
		

func _getDataSize(sizeText: String):
	match sizeText:
		"":
			return DataSizes.EMPTY
		"b":
			return DataSizes.BYTE
		"w":
			return DataSizes.WORD
#		"t":
#			return DataSizes.TRIPLE_BYTE
		"l","s":
			return DataSizes.DOUBLE_WORD
		"q","d":
			return DataSizes.QUAD_WORD
		_: # GDscript alternative of default
			return null

func _getNumber():
	return int(parsingLines[curTextPos.y].right(curTextPos.x).strip_edges())

# Data, Size Of Data
func _writeData(data: int, size: int):
	if (pow(2,size*8) <= data):
		print("Error: ", data, " is too high number for ", size, " byte(s)")
	elif (size != 0):
		var temp = data
		for i in range(size):
			rawData.push_back(temp&0xFF)
			temp >>= 8
			print(temp)
			pass
	else:
		print("Warning: Size is 0")

func _executeDC():
	print(_getNumber())
	_writeData(_getNumber(), _getDataSize(cmdSize))
#	print(parsingLines[curTextPos.y].right(curTextPos.x).strip_edges())

func _executeRS():
	print("RS executed")
