/*
	Custom Crosshair Shader by: Quot3e
	https://github.com/Quot3e/godot-crosshair-shader
	
	MIT License
*/

shader_type canvas_item;

uniform bool is_symmetric = true;
uniform vec2 center_offset;
uniform vec4 line_color : source_color = vec4(1.0);
uniform vec4 line_outline_color : source_color = vec4(vec3(0.0), 1);
uniform vec2 line_length = vec2(20.0);
uniform vec2 line_thickness = vec2(1.0);
uniform vec2 line_offset = vec2(10.0);
uniform vec2 line_outline_thickness = vec2(1.0);

uniform vec4 dot_color : source_color = vec4(1.0);
uniform vec4 dot_outline_color : source_color= vec4(vec3(0.0), 1.0);
uniform float dot_size = 2.0;
uniform float dot_outline_thickness = 1.0;

float center_line(float value, float thickness) {
	return step(distance(0.5, value), thickness);
}

float crosshair_segment(float thickness, float offset, float range, float outline, vec2 pixel, vec2 uv){
	
	thickness = round(thickness);
	offset = round(offset);
	range = round(range);
	outline =  round(outline);
	
	if (is_symmetric){
		thickness = thickness * 2.0 - 1.0;
		offset = offset * 2.0 - 1.0;
		range = range * 2.0;
		outline =  outline * 2.0;
	}
	
	float line = center_line(uv.x, (thickness + outline) * pixel.x);
	line *= 1.0 - center_line(uv.y, (offset - outline) * pixel.y);
	line *= center_line(uv.y, (range + offset + outline) * pixel.y);
	return line;
}

float center_square(float size, float outline, vec2 pixel, vec2 uv){
	size = round(size);
	outline = round(outline);
	
	if (is_symmetric){
		size = size * 2.0 - 1.0;
		outline = outline * 2.0;
	}
	
	float center_dot = center_line(uv.x, (size + outline) * pixel.x);
	center_dot *= center_line(uv.y, (size + outline) * pixel.y);
	return center_dot;
}

vec4 blend_layers(vec4 bottom, vec4 top) {
	float final_alpha = top.a + bottom.a * (1.0 - top.a);
	float safe_div = step(0.0001, final_alpha);
	vec3 final_color = (top.rgb * top.a + bottom.rgb * bottom.a * (1.0 - top.a)) / max(final_alpha, 0.0001);
	return vec4(final_color, final_alpha * safe_div);
}

void fragment() {
	vec2 uv = FRAGCOORD.xy * SCREEN_PIXEL_SIZE + center_offset;
	vec2 pixel = SCREEN_PIXEL_SIZE/2.0;
	
	float line_x = crosshair_segment(line_thickness.x, line_offset.x, line_length.x, 0.0, pixel.yx, uv.yx);
	float line_y = crosshair_segment(line_thickness.y, line_offset.y, line_length.y, 0.0, pixel, uv);
	
	float line_outline_x = crosshair_segment(line_thickness.x, line_offset.x, line_length.x, line_outline_thickness.x, pixel.yx, uv.yx);
	float line_outline_y = crosshair_segment(line_thickness.y, line_offset.y, line_length.y, line_outline_thickness.y, pixel, uv);
	
	float center_dot = center_square(dot_size, 0.0, pixel, uv);
	float center_dot_outline = center_square(dot_size, dot_outline_thickness, pixel, uv);
	
	vec4 center_dot_layer = center_dot * dot_color + (center_dot_outline - center_dot) * dot_outline_color;
	vec4 line_layer1 = line_x * line_color + (line_outline_x - line_x) * line_outline_color;
	vec4 line_layer2 = line_y * line_color + (line_outline_y - line_y) * line_outline_color;
	
	vec4 blended_result = center_dot_layer;
	blended_result = blend_layers(blended_result, line_layer1);
	blended_result = blend_layers(blended_result, line_layer2);
	
	COLOR = blended_result;
}
