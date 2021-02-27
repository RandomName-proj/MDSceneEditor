tool
extends Area2D

var isDragged:= false
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
export(ButtonList) var mouseButton = BUTTON_LEFT
export(Vector2) var DragBoxSize = Vector2(16,16)

# Called when the node enters the scene tree for the first time.
func _ready():
	$DragBox.scale = DragBoxSize


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.editor_hint:
		if (isDragged and Input.is_mouse_button_pressed(mouseButton)):
			global_position = get_global_mouse_position()
		print(Input.is_mouse_button_pressed(mouseButton))
	else:
		$DragBox.scale = DragBoxSize


func _on_Draggable_mouse_entered():
	isDragged = true


func _on_Draggable_mouse_exited():
	if (!Input.is_mouse_button_pressed(mouseButton)):
		isDragged = false
