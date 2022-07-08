extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal changed_level
signal draw_ui

func _on_LevelFile_file_selected(path):
	$Level.load_file(path)
	emit_signal("changed_level",$Level)
