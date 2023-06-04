shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec3[64] palette;

void fragment() {
	vec4 color_data = textureLod(screen_texture, SCREEN_UV,0);
	if (color_data.b > 0.0f) {
		COLOR.a = 0.0f;
	}
	else {
		COLOR.rgb = palette[int(color_data.r*256.0f+(1.0f-color_data.g)*64.0f)];
	}
	
}