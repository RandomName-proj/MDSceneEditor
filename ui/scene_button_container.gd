extends CenterContainer

@onready var scene_res : PackedScene = preload("res://scene.tscn")
@onready var file_dialog := $PanelContainer/Button/FileDialog

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	file_dialog.popup_centered()


func _on_file_dialog_file_selected(path):
	var scene_inst := scene_res.instantiate()
	scene_inst.scene_name = path.get_file() # remember scene file name
	scene_inst.name = path.get_file() # simply for convenience
	owner.scene_tab_container.add_child(scene_inst)
	
	scene_inst.load_scene(path)
	
	visible = false
	
