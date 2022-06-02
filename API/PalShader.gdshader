shader_type canvas_item;
render_mode blend_disabled;

uniform sampler2D palette;

void fragment(){
	COLOR = texture(TEXTURE, UV);
	float color_index = COLOR.r+MODULATE.r; // get modulate data (object's palette line)
	
	COLOR.rgb = texture(palette,vec2(color_index,0)).rgb;
}