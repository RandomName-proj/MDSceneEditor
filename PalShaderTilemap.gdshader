shader_type canvas_item;
render_mode blend_mix;
uniform vec2 node_size = vec2(400.0, 400.0);

uniform sampler2D palette;
uniform int pal_line;

varying vec2 vert;

void vertex(){
	vert = VERTEX;
}

void fragment(){
	vec2 full_uv = vert/node_size;
	COLOR = texture(TEXTURE,UV);
	float color_index = COLOR.r*4.0f+float(pal_line)*16.0f/64.0f;
	
	COLOR.rgb = texture(palette,vec2(color_index,0)).rgb;
}