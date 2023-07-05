extends Node2D

@onready var tile_layout_scene = preload("res://layers/tile_layout/tile_layout.tscn")

func add_tile_layout(tile_layout : String):
	var tile_layout_node := tile_layout_scene.instantiate()
	tile_layout_node.name = tile_layout
	$TileLayouts.add_child(tile_layout_node)

func find_tile_layout(tile_layout : String) -> Node:
	return $TileLayouts.find_child(tile_layout, false, false)
