shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform vec3 tint_color = vec3(1, 1, 1);

void fragment() {
    COLOR = textureLod(screen_texture, SCREEN_UV, 0.0);
	COLOR.rgb *= tint_color;
}
