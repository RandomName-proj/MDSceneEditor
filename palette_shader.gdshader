shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D palette;

void fragment(){
	vec4 tile_metadata = COLOR;
	COLOR = texture(TEXTURE,UV);
	float color_index = COLOR.r+tile_metadata.r;
	COLOR.rgb = texture(palette,vec2(color_index,0)).rgb;
}