extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level_scene := preload("res://Level.tscn")
var level : Node

signal changed_level

func load_level(path : String):
	if level != null:
		# delete previous level scene
		remove_child(level)
		level.queue_free()
	# add a new level scene
	level = level_scene.instance()
	add_child(level)
	level.load_file(path)

func _on_LevelFile_file_selected(path):
	if level != null:
		remove_child(level)
		level.queue_free()
	level = level_scene.instance()
	add_child(level)
	level.load_file(path)
	emit_signal("changed_level",level)
