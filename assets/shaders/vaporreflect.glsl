uniform float shadowheight;
uniform float pos_y;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
	vec4 finalcol = color;
	vec4 col = Texel(texture, texture_coords);
	float anycol = col.a * 99999999.0;
	finalcol.rgb *= vec3(anycol,anycol,anycol);
	col.a = 1.0 * mix(col.a, 0.0, clamp((screen_coords.y - pos_y)/shadowheight * 2.0, 0.65, 1.0));
	finalcol.rgb = color.rgb * col.rgb * col.a;
	finalcol.a = anycol;
	return finalcol;
}
