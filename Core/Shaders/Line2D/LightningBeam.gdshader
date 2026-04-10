shader_type canvas_item;

uniform vec4 lightning_color: source_color;
uniform sampler2D lightning_noise : repeat_enable;
uniform float noise_scale : hint_range(0.1, 50.0) = 8.0;
uniform float noise_amp : hint_range(0.0, 1.0) = 0.15;

uniform float size: hint_range (0.,1.);
uniform float width: hint_range (0.,1.);
uniform float speed;
uniform float cycle: hint_range(0.0, 7.0) ;


float rand(float x){
	return fract(sin(x)*100000.0);
}

void fragment(){
	float n = texture(lightning_noise, vec2(UV.x * noise_scale, TIME)).r;
	float n_signed = n * 2.0 - 1.0;

	float bolt = abs(mod(UV.x * cycle - TIME * speed, 0.5) - 0.25) - 0.125;

	bolt += n_signed * noise_amp;
	bolt *= 4. * width;
	bolt *=  (0.5 - abs(UV.x-0.5)) * 2.; 

	float wave = abs(UV.y - 0.5 + bolt);
	wave = 1.0 - step(size * 0.5, wave);
	
	vec4 display = lightning_color * vec4(wave);
	
	COLOR = display;
}
