shader_type canvas_item;


uniform vec4 ori_color: source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 new_color: source_color;
uniform float threshold: hint_range(0.0, 1.75, 0.001) = 1.0;


vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	vec4 current_color = texture(TEXTURE, UV);
	vec3 current_hsv = rgb2hsv(current_color.rgb);
	float diff = length(current_color.rgb - ori_color.rgb);
	if (diff < threshold) {
		vec3 ori_hsv = rgb2hsv(ori_color.rgb);
		vec3 new_hsv = rgb2hsv(new_color.rgb);
		new_hsv = vec3(
			new_hsv.r,
			current_hsv.g,
			current_hsv.b
		);
		COLOR.rgb = hsv2rgb(new_hsv);
	}
}
