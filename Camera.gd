extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (float) var zoom_factor = 0.1
var shift_pressed = false
var dir_pressed := {"left": false, "right": false, "up": false, "down": false}
var direction := Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport().size/2

func _unhandled_input(event):
	if event is InputEventKey and not event.echo:
		
		if event.is_action("ui_shift"):
			shift_pressed = event.pressed
		
		if event.is_action("ui_right"):
			dir_pressed["right"] = event.pressed
		if event.is_action("ui_left"):
			dir_pressed["left"] = event.pressed
		if event.is_action("ui_up"):
			dir_pressed["up"] = event.pressed
		if event.is_action("ui_down"):
			dir_pressed["down"] = event.pressed
		
		direction.x = int(dir_pressed["right"]) - int(dir_pressed["left"])
		direction.y = int(dir_pressed["down"]) - int(dir_pressed["up"])
		
	if event is InputEventMouseButton and not event.pressed:
		if event.is_action("ui_mouse_wheel_up"):
			zoom = Vector2(max(zoom.x-zoom_factor,zoom_factor),max(zoom.y-zoom_factor,zoom_factor))
		if event.is_action("ui_mouse_wheel_down"):
			zoom += Vector2(zoom_factor,zoom_factor)
		

	

func _process(delta):
	if shift_pressed:
		position += direction*32
	else:
		position += direction*16
