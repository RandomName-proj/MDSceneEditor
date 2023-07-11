extends Node2D

@onready var res_pool : MDResourcePool = $Resources
@onready var vram := $Hardware/VRAM
@onready var palette := $Hardware/Palette
@onready var fg := $CanvasLayer/HardwareContainer/HardwareViewport/FG
@onready var bg := $CanvasLayer/HardwareContainer/HardwareViewport/BG
@onready var scene_camera := $CanvasLayer/HardwareContainer/HardwareViewport/Camera2D

var scene_name : String

func _ready():
	scene_camera.position += get_viewport_rect().size/2

func load_scene(path : String):
	
	if (SceneLoader.load_scene(path, res_pool)):
		$Engine.load_scene()
	

func get_plane(plane : String):
	if plane.to_upper() == "FG":
		return fg
	elif plane.to_upper() == "BG":
		return bg
	else:
		Global.console.printerr("Error: unknown plane '{plane}'".format({"plane":plane}))
		return null

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
