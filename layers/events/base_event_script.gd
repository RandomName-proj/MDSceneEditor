extends Node
class_name BaseEventScript

var data : BaseEventFormat
var mdse_scene : Node2D

func setup(d: BaseEventFormat, sc : Node2D):
	Global.console.printerr("The event script is not implemented")

func load_event(d : BaseEventFormat, script_path : String, sc : Node2D):
	self.script = load(script_path)
	setup(d,sc)
