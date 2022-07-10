extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pal_button_script := preload("res://PaletteButton.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(64):
		var child := ColorPickerButton.new()
		child.set_script(pal_button_script)
		child.pal_ind = i
		add_child(child)
		child.owner = owner

func _process(delta):
	if owner.level == null:
		visible = false
	else:
		visible = true

func _on_World_changed_level(selected_level):
	for child in get_children():
		print(child.get_script())
		child.color = selected_level.palette.get_palette_entry(child.pal_ind)
