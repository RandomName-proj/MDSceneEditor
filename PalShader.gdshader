shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D palette;
uniform int pal_line;

void fragment(){
	COLOR = texture(TEXTURE,UV);
	float color_index = COLOR.r*4.0f+float(pal_line)*16.0f/64.0f;
	
	COLOR.rgb = texture(palette,vec2(color_index,0)).rgb;
}
