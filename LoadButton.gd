extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LoadButton_pressed():
	$FileSelect.popup_centered()


func _on_FileSelect_file_selected(path):
	Global.root.load_data(path)
