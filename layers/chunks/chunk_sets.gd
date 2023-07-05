extends Node

@onready var tile_set_scene = preload("res://layers/chunks/chunks.tscn")

func add_tile_set(tile_set : String):
	var tile_set_node := tile_set_scene.instantiate()
	tile_set_node.name = tile_set
	add_child(tile_set_node)

func find_tile_set(tile_set : String) -> Node:
	return find_child(tile_set, false, false)

