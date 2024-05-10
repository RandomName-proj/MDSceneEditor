extends Node

func add_event(event : String):
	var event_node = BaseEventScript.new()
	event_node.name = event
	add_child(event_node)

func find_event(event_node : String) -> Node:
	return find_child(event_node, false, false)
