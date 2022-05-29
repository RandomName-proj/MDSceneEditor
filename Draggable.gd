tool
extends Area2D

signal moved(movement)

var is_dragged:= false
var is_colliding:= false

var prev_mouse_button:= Vector2(0,0)

 # GDScript can't reference global enums directly for some reason
enum ButtonList {
	BUTTON_LEFT = BUTTON_LEFT,
	BUTTON_RIGHT = BUTTON_RIGHT,
	BUTTON_MIDDLE = BUTTON_MIDDLE,
	BUTTON_XBUTTON1 = BUTTON_XBUTTON1,
	BUTTON_XBUTTON2 = BUTTON_XBUTTON2,
	BUTTON_WHEEL_UP = BUTTON_WHEEL_UP,
	BUTTON_WHEEL_DOWN = BUTTON_WHEEL_DOWN,
	BUTTON_WHEEL_LEFT = BUTTON_WHEEL_LEFT,
	BUTTON_WHEEL_RIGHT = BUTTON_WHEEL_RIGHT
}
export(ButtonList) var mouse_button = BUTTON_LEFT
export(Vector2) var drag_box_size = Vector2(16,16)

# Called when the node enters the scene tree for the first time.
func _ready():
	$DragBox.scale = drag_box_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.editor_hint:
		if ((is_dragged or is_colliding) and Input.is_mouse_button_pressed(mouse_button)):
			is_dragged = true
			if (get_global_mouse_position()-prev_mouse_button != Vector2(0,0)):
				emit_signal("moved",get_global_mouse_position()-prev_mouse_button)
				
			position += get_global_mouse_position()-prev_mouse_button
		else:
			is_dragged = false
		prev_mouse_button = get_global_mouse_position()
		
	else:
		$DragBox.scale = drag_box_size


func _on_Draggable_mouse_entered():
	is_colliding = true


func _on_Draggable_mouse_exited():
	is_colliding = false


func _on_Draggable_moved(movement):
	print(movement)
