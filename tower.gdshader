shader_type canvas_item;

uniform float width : hint_range(0.0, 30.0);
uniform vec4 outline_color : source_color;

uniform int apply_outline : hint_range(0,1);

void fragment()
{
	float size = width * 1.0 / float(textureSize(TEXTURE, 0).x);
	vec4 sprite_color = texture(TEXTURE, UV);
	float alpha = -4.0 * sprite_color.a;
	
	if (apply_outline == 0) {
		
		COLOR = vec4(COLOR.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));}
		
	else {

	alpha += texture(TEXTURE, UV + vec2(size,0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-size,0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0,size)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0,-size)).a;
	
	vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0, 1));
	COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
	}
	
	
	

}
