extends Node

var console : Window

const ENABLE_CONSOLE := false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_viewport().set_embedding_subwindows(false)
	var console_window := preload("res://console/console.tscn")
	var w : Window = console_window.instantiate()
	w.visible = false
	add_child(w)
	console = w
	
	if ENABLE_CONSOLE:
		console.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
