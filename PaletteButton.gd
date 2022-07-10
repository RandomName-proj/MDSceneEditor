extends ColorPickerButton

var pal_ind : int = 0

func _ready():
	enabled_focus_mode = Control.FOCUS_CLICK
	size_flags_horizontal |= SIZE_EXPAND
	size_flags_vertical |= SIZE_EXPAND
	edit_alpha = false
	connect("popup_closed", self, "_on_color_apply")

func _on_color_apply():
	if owner.level != null:
		owner.level.palette.set_palette_entry(color, pal_ind)
