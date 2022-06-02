extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var id : int
var subtype : int

# Called when the node enters the scene tree for the first time.
func _ready():
	$Container/IDContainer/ID.text = str(id)
	#$Container/SubtypeContainer/Subtype.text = str(subtype)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
