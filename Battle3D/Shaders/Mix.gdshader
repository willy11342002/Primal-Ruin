shader_type spatial;

// 渲染模式：不收光照影響，雙面渲染，強制寫入深度
render_mode unshaded, depth_draw_always, cull_disabled;

// --- 通用參數 ---
uniform sampler2D albedo_texture : source_color, filter_nearest;

// --- 1. 外框線參數 (Outline) ---
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 1.0;

// --- 2. 石化/雜訊參數 (Stone/Grain) ---
uniform float stone_mix : hint_range(0.0, 1.0) = 0.0; // 0為原圖, 1為石化
uniform vec3 stone_color : source_color = vec3(0.4, 0.4, 0.4);
uniform float grain_intensity : hint_range(0.0, 0.5) = 0.15;
uniform float grain_scale : hint_range(1.0, 10.0) = 1.0;

// --- 3. 受傷閃爍參數 (Flash) ---
uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flash_state : hint_range(0.0, 1.0) = 0.0; // 0為正常, 1為全閃爍

// --- 輔助函數 ---
float rand(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void vertex() {
	// --- Billboard 效果：讓面片永遠朝向攝像機 ---
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
		INV_VIEW_MATRIX[0], 
		INV_VIEW_MATRIX[1], 
		INV_VIEW_MATRIX[2], 
		MODEL_MATRIX[3]
	);
	
	// 補回縮放值
	float scale_x = length(MODEL_MATRIX[0].xyz);
	float scale_y = length(MODEL_MATRIX[1].xyz);
	float scale_z = length(MODEL_MATRIX[2].xyz);
	MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(
		vec4(scale_x, 0, 0, 0),
		vec4(0, scale_y, 0, 0),
		vec4(0, 0, scale_z, 0),
		vec4(0, 0, 0, 1)
	);
}

void fragment() {
	// 1. 取樣原始顏色
	vec4 main_tex = texture(albedo_texture, UV);
	
	// --- 處理外框線邏輯 ---
	vec2 tex_size = vec2(textureSize(albedo_texture, 0));
	vec2 edge_offset = vec2(outline_width) / tex_size;
	
	float max_alpha = main_tex.a;
	max_alpha = max(max_alpha, texture(albedo_texture, UV + vec2(0.0, edge_offset.y)).a);
	max_alpha = max(max_alpha, texture(albedo_texture, UV + vec2(0.0, -edge_offset.y)).a);
	max_alpha = max(max_alpha, texture(albedo_texture, UV + vec2(edge_offset.x, 0.0)).a);
	max_alpha = max(max_alpha, texture(albedo_texture, UV + vec2(-edge_offset.x, 0.0)).a);
	
	// --- 處理石化/雜訊顏色 ---
	float lum = dot(main_tex.rgb, vec3(0.299, 0.587, 0.114));
	vec2 pixel_uv = floor(UV * tex_size / grain_scale);
	float noise = rand(pixel_uv) * 2.0 - 1.0;
	
	vec3 stone_rgb = stone_color;
	stone_rgb += noise * grain_intensity;
	stone_rgb *= (lum + 0.2) * 1.2;
	
	// --- 顏色層疊處理 ---
	// A. 先決定基礎顏色 (原始貼圖 vs 石化顏色)
	vec3 base_color = mix(main_tex.rgb, stone_rgb, stone_mix);
	
	// B. 疊加受傷閃爍 (在基礎顏色之上混合)
	base_color = mix(base_color, flash_color.rgb, flash_state);
	
	// C. 最終輸出與外框線判定
	if (main_tex.a < 0.1 && max_alpha > 0.1) {
		// 這裡是外框線部分
		ALBEDO = outline_color.rgb;
		ALPHA = outline_color.a;
	} else if (main_tex.a < 0.5) {
		// 完全透明處丟棄
		discard;
	} else {
		// 角色本體部分
		ALBEDO = base_color;
		ALPHA = main_tex.a;
	}
}