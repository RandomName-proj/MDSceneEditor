extends Window

@onready var text_node := $PanelContainer/Text

# Called when the node enters the scene tree for the first time.
func _ready():
	text_node.push_font_size(18)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func print(text):
	if Global.ENABLE_CONSOLE:
		text_node.append_text(text+"\n")
	else:
		print(text)

func printerr(text):
	if Global.ENABLE_CONSOLE:
		text_node.append_text("[color=red]"+"• "+text+"[/color]"+"\n")
	else:
		printerr(text)

func printwarn(text):
	if Global.ENABLE_CONSOLE:
		text_node.append_text("[color=yellow]"+"• "+text+"[/color]"+"\n")
	else:
		print("Warning: ", text)
		push_warning(text)
