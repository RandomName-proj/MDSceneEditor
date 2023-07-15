extends Node2D

var id
var additional : Dictionary
var flags : int

var mdse_scene : Node2D : set = _set_mdse_scene
var object_script : Dictionary

func _set_mdse_scene(sc : Node2D):
	mdse_scene = sc
	mdse_scene.connect("loaded_scene",_on_scene_loaded_scene)

func _on_scene_loaded_scene():
	$Sprite.texture = mdse_scene.vram.texture
