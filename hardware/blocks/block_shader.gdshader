shader_type canvas_item;

uniform sampler2D tile_set_texture;
uniform float tex_width;
uniform float tex_height;
uniform float tile_width;
uniform float tile_height;
uniform float tile_rows;

void fragment() {
	//    Source: https://github.com/AndreVallestero/godot-tile-map-shader/blob/main/main.tscn
	//    The tile used is stored in the Red value
	//    Since there are 4 source tiles, we normalize it to 0., 1., 2., and 3.
	//float tileIdx = floor(texture(TEXTURE, UV).r * 4.);
	//    To get the tile offset, we must move it to the right by
	//    idx * tile_width / texture_width
	//float tileOffsetX = tileIdx * 16. / 80.;
	//    tilemap_rows / texture_height
	//float tileOffsetY = 45. / 61.;
	//    Map and normalize the x to the tile x,
	//    (UV.x * texture_width) % 1 * tile_width / texture_width
	//float normX = mod(UV.x * 80., 1) * 16. / 80.;
	//    Map and normalize the y to the tile y,
	//    (UV.y * texture_height) % 1 * tile_height / texture_height
	//float normY = mod(UV.y * 61., 1) * 16. / 61.;
	//vec2 coord = vec2(tileOffsetX + normX, tileOffsetY + normY);
	//COLOR = texture(TEXTURE, coord);
	
	float tileIdx = floor(texture(TEXTURE, UV).r * 2.);
	float tileOffsetX = tileIdx * tile_width / tex_width;
	float tileOffsetY = tile_rows / tex_height;
	float normX = mod(UV.x * tex_width, 1) / tex_width;
	float normY = mod(UV.y * tex_height, 1) / tex_height;
	vec2 coord = vec2(tileOffsetX + normX, tileOffsetY + normY);
	COLOR = texture(tile_set_texture, coord);
}