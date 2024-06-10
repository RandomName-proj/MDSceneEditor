extends Node
class_name BaseObjectScript

@export var unknown_object_sprite = preload("res://layers/object/unknown_object_sprite.tscn")

var unk_obj : CanvasItem

var data : BaseObjectLayoutEntry
var mdse_scene : MDSEScene
var metadata : Dictionary

func setup(d : BaseObjectLayoutEntry, meta: Dictionary, sc : MDSEScene):
#	Global.console.printerr("The object script is not implemented")
	
	data = d
	mdse_scene = sc
	metadata = meta
	
	unk_obj = unknown_object_sprite.instantiate()
	
	add_child(unk_obj)
	
	self.position = Vector2(data.x_pos,data.y_pos)
	
	

func load_object(d : BaseObjectLayoutEntry, meta: Dictionary, sc : MDSEScene):
	
	if not meta.is_empty():
		self.script = load(meta["script"])
	
	setup(d, meta, sc)
