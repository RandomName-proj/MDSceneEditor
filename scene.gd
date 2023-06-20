extends Node2D

@onready var res_pool : MDResourcePool = $Resources
@onready var vram := $Hardware/VRAM
@onready var palette := $Hardware/Palette
@onready var scene_camera := $CanvasLayer/HardwareContainer/HardwareViewport/Camera2D

func _ready():
	$Engine.do_the_thing()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir := Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	
	var zoom = scene_camera.zoom
	
	if Input.is_action_just_released("zoom_in"):
		zoom += 0.1 * Vector2.ONE
	if Input.is_action_just_released("zoom_out"):
		zoom -= 0.1 * Vector2.ONE
	
	
	scene_camera.zoom = Vector2(max(zoom.x,0.1),max(zoom.y,0.1))
	
	scene_camera.position += dir*30
