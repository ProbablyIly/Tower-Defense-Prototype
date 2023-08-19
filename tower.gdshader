shader_type canvas_item;

uniform float width : hint_range(0.0, 30.0); // outline width
uniform vec4 outline_color : source_color; // outline color

uniform int apply_outline : hint_range(0,1); // apply outline or not

void fragment()
{
	float size = width * 1.0 / float(textureSize(TEXTURE, 0).x); // outline width in pixels
	vec4 sprite_color = texture(TEXTURE, UV); // sprite color
	float alpha = -4.0 * sprite_color.a; // alpha value of the final color
	
	if (apply_outline == 1) {
			
	alpha += texture(TEXTURE, UV + vec2(size,0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-size,0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0,size)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0,-size)).a;
	

	vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0, 1));
	COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
		
		}

	}


