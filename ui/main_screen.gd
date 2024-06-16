extends Control

@onready var scene_tab_container := $TabContainer

@onready var scene_button_container := $SceneButtonContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("escape"):
		scene_button_container.visible = true
