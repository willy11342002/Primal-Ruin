shader_type spatial;
// 這裡維持原樣
render_mode unshaded, depth_draw_always, cull_disabled;

uniform sampler2D albedo_texture : source_color, filter_nearest; 
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 1.0;

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
	// Fragment 部分保持不變
	vec4 col = texture(albedo_texture, UV);
	vec2 size = vec2(outline_width) / vec2(textureSize(albedo_texture, 0));
	
	float alpha = col.a;
	alpha = max(alpha, texture(albedo_texture, UV + vec2(0.0, size.y)).a);
	alpha = max(alpha, texture(albedo_texture, UV + vec2(0.0, -size.y)).a);
	alpha = max(alpha, texture(albedo_texture, UV + vec2(size.x, 0.0)).a);
	alpha = max(alpha, texture(albedo_texture, UV + vec2(-size.x, 0.0)).a);
	
	if (col.a < 0.1 && alpha > 0.1) {
		ALBEDO = outline_color.rgb;
		ALPHA = outline_color.a;
	} else {
		ALBEDO = col.rgb;
		ALPHA = col.a;
	}
}