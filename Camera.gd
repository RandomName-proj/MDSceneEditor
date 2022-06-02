extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (float) var zoom_factor = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport().size/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var dir := Vector2(0,0)
	
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	
	if Input.is_action_just_released("ui_mouse_wheel_up"):
		zoom = Vector2(max(zoom.x-zoom_factor,zoom_factor),max(zoom.y-zoom_factor,zoom_factor))
	if Input.is_action_just_released("ui_mouse_wheel_down"):
		zoom += Vector2(zoom_factor,zoom_factor)
	
	if Input.is_action_pressed("ui_shift"):
		position += dir*32
	else:
		position += dir*16
	
