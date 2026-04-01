shader_type spatial;

// 讓 Sprite3D 支持 Alpha 通道（透明背景），並保持像素銳利
render_mode unshaded;

// --- Uniforms ---
// 原始貼圖
uniform sampler2D albedo_texture : source_color, filter_nearest;

// 受傷閃爍的顏色 (預設為純白，也可以設為紅色)
uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

// 控制閃爍狀態：0.0 = 正常顏色, 1.0 = 完全顯示 flash_color
// 這個參數是用來做動畫的
uniform float flash_state : hint_range(0.0, 1.0) = 0.0;

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
    // 1. 取樣原始貼圖的顏色和 Alpha
    vec4 tex_color = texture(albedo_texture, UV);
    
    // 2. 透明度處理 (重要：保持邊緣硬朗)
    if (tex_color.a < 0.5) {
        discard;
    }

    // 3. 核心邏輯：混合顏色
    // 我們使用 mix 函數，根據 flash_state 在「原圖 RGB」和「閃爍 RGB」之間插值
    // 注意：mix 的第三個參數 flash_state 如果是 0，結果就是 tex_color.rgb；如果是 1，結果就是 flash_color.rgb
    vec3 final_rgb = mix(tex_color.rgb, flash_color.rgb, flash_state);
    
    // 4. 輸出最終顏色，保持原本的透明度
    ALBEDO = final_rgb;
	ALPHA = tex_color.a;
}