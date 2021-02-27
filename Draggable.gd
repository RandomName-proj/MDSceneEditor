tool
extends Area2D

signal moved(movement)

var isDragged:= false
var isColliding:= false

var prevMousePosition:= Vector2(0,0)

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
		if ((isDragged or isColliding) and Input.is_mouse_button_pressed(mouseButton)):
			isDragged = true
			if (get_global_mouse_position()-prevMousePosition != Vector2(0,0)):
				emit_signal("moved",get_global_mouse_position()-prevMousePosition)
				
			position += get_global_mouse_position()-prevMousePosition
		else:
			isDragged = false
		prevMousePosition = get_global_mouse_position()
		
	else:
		$DragBox.scale = DragBoxSize


func _on_Draggable_mouse_entered():
	isColliding = true


func _on_Draggable_mouse_exited():
	isColliding = false


func _on_Draggable_moved(movement):
	print(movement)
