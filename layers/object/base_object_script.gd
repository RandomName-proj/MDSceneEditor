extends Node
class_name BaseObjectScript

@export var unknown_object_sprite = preload("res://layers/object/unknown_object_sprite.tscn")

var unk_obj : CanvasItem

var data : BaseObjectLayoutEntry
var mdse_scene : MDSEScene
var metadata : Dictionary

func _base_setup(d : BaseObjectLayoutEntry, meta: Dictionary, sc : MDSEScene):
	self.data = d
	self.mdse_scene = sc
	self.metadata = meta
	self.position = Vector2(data.x_pos,data.y_pos)
	setup()

func setup():
#	Global.console.printerr("The object script is not implemented")
	
	unk_obj = unknown_object_sprite.instantiate()
	
	add_child(unk_obj)
	
	

func load_object(d : BaseObjectLayoutEntry, meta: Dictionary, sc : MDSEScene):
	
	if meta.has("script"):
		self.script = load(FileHelper.format_filepath(meta["script"], sc.directory))
	elif meta.has("mappings"):
		self.script = load("res://layers/object/standart_object_script.gd")
	
	_base_setup(d,meta,sc)
