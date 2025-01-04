extends Node
class_name BaseEventScript

var data : BaseEventFormat
var mdse_scene : MDSEScene

func setup(d: BaseEventFormat, sc : MDSEScene):
	Global.console.printerr("The event script is not implemented")

func load_event(d : BaseEventFormat, script_path : String, sc : MDSEScene):
	self.script = load(FileHelper.format_filepath(script_path, sc.directory))
	setup(d,sc)
