shader_type spatial;

// 讓 Sprite3D 支持 Alpha 通道（透明背景）
render_mode unshaded; 

// --- Uniforms ---
uniform sampler2D albedo_texture : source_color, filter_nearest; // 保持像素銳利
uniform float mix_amount : hint_range(0.0, 1.0) = 1.0;
uniform vec3 stone_color : source_color = vec3(0.4, 0.4, 0.4);
uniform float grain_intensity : hint_range(0.0, 0.5) = 0.15;
uniform float grain_scale : hint_range(1.0, 10.0) = 1.0;

// --- 偽隨機函數 ---
float rand(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void vertex() {
	// --- 手動實現 Billboard 效果 ---
	// 1. 取得模型在視圖空間（View Space）的位置
	// 2. 移除模型矩陣中的旋轉，讓它永遠對齊攝像機平面
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
		INV_VIEW_MATRIX[0], 
		INV_VIEW_MATRIX[1], 
		INV_VIEW_MATRIX[2], 
		MODEL_MATRIX[3]
	);
	
	// 如果你原本有縮放（Scale），需要補回縮放值
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
    // 1. 取樣原始貼圖
    vec4 tex = texture(albedo_texture, UV);
    
    // 2. 透明度處理 (重要：避免 3D 空間中的透明方塊)
    if (tex.a < 0.5) {
        discard;
    }

    // 3. 計算明暗度 (Luminance)
    float lum = dot(tex.rgb, vec3(0.299, 0.587, 0.114));

    // 4. 計算像素對齊的顆粒感
    // 在 3D 中，我們使用原始貼圖的分辨率來定位像素格
    vec2 texture_size = vec2(textureSize(albedo_texture, 0));
    vec2 pixel_uv = floor(UV * texture_size / grain_scale);
    float noise = rand(pixel_uv) * 2.0 - 1.0;

    // 5. 合成石頭顏色
    // 稍微加強對比度，讓像素點在 3D 環境中更明顯
    vec3 stone_rgb = stone_color;
    stone_rgb += noise * grain_intensity;
    stone_rgb *= (lum + 0.2) * 1.2; 
    
    // 6. 最終混合
    vec3 final_color = mix(tex.rgb, stone_rgb, mix_amount);

    ALBEDO = final_color;
    ALPHA = tex.a;
}