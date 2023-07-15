extends Node2D

@onready var object_layer_scene = preload("res://layers/object/object_layer.tscn")

func add_object_layer(object_layer : String):
	var object_layer_node := object_layer_scene.instantiate()
	object_layer_node.name = object_layer
	add_child(object_layer_node)

func find_object_layer(object_layer : String) -> Node2D:
	return find_child(object_layer, false, false)
