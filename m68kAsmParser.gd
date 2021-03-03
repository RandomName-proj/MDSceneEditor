extends Resource
class_name m68kAsmParser

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var parsingLines: PoolStringArray
var curTextPos:= Vector2(0,0)
var cmdStartPos:= Vector2(0,0)

const stopSymbols: = " .\t\n" # symbols where each command ends
const gapSymbols: = " \t\n" # symbols which end commands, but are not part of them

enum DataSizes {
	BYTE,WORD,TRIPLE_BYTE,DOUBLE_WORD,
	FIVE_BYTES,QUAD_WORD,SIX_WORDS
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func parse(text: String):
	parsingLines = text.split("\n")
#	print(parsingLines)
	_executeCommand()
	return text

func _executeCommand():
	var cmd = _getNextCommand()
	print(parsingLines[0])
	print(cmd)

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
	
	var cmd = parsingLines[cmdStartPos.y].right(cmdStartPos.x)
	for i in stopSymbols:
		if (cmd.find(i) != -1):
			cmd = cmd.substr(cmdStartPos.x-1,cmd.find(i)-cmdStartPos.x+1)
	
	curTextPos.x += cmd.length()
	return cmd

func _getDataSize(sizeText: String):
	match sizeText:
		"b":
			return DataSizes.BYTE
		"w":
			return DataSizes.WORD
		"24":
			return DataSizes.TRIPLE_BYTE
		"l","s":
			return DataSizes.DOUBLE_WORD
		"q","d":
			return DataSizes.QUAD_WORD
		"x":
			return DataSizes.SIX_WORDS
		_: # GDscript alternative of default
			return null


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
