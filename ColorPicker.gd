extends ColorPicker


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# limits color picker's color to palette limitations
func _limitcolor(color : Color, palArr: Array) -> Color:
	var colordiff := Color(0, 0, 0, 0) # to support raw colors higher than 1.0
	
	if color.r > 1:
		colordiff.r = color.r - 1
	
	if color.g > 1:
		colordiff.g = color.g - 1
	
	if color.b > 1:
		colordiff.b = color.b - 1 
	
	var startcolor := [color.r8, color.g8, color.b8]
	
	for ind in range(0,startcolor.size()):
		var colordist = abs(palArr[0]-startcolor[ind])
		var closestcolor = palArr[0]
		
		for pal in palArr:
			if abs(pal-startcolor[ind]) < colordist:
				colordist = abs(pal-startcolor[ind])
				closestcolor = pal
		
		startcolor[ind] = closestcolor
	
	return Color8(startcolor[0], startcolor[1], startcolor[2]) + colordiff


func _on_ColorPicker_mouse_exited():
	color = _limitcolor(color, PaletteHandler.genColorArr)
