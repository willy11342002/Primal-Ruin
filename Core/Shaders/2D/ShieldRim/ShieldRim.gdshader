shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(0.0, 0.8, 1.0, 1.0);
uniform float _Radius = 0.45;

// 定義最大碰撞點數量（例如 5 個）
const int MAX_CONTACTS = 5;
uniform vec2 hit_points[MAX_CONTACTS];
uniform float hit_intensities[MAX_CONTACTS];
uniform int actual_contacts = 0; // 當前真正的碰撞數量

void fragment() {
    vec2 center = vec2(0.5);
    float dist = distance(UV, center);
    
    // 1. 基礎圓形邊緣
    float rim = smoothstep(_Radius - 0.02, _Radius, dist) * smoothstep(_Radius + 0.01, _Radius, dist);
    
    // 2. 遍歷所有碰撞點疊加遮罩
    float total_hit_mask = 0.0;
    
    for (int i = 0; i < actual_contacts; i++) {
        float dist_to_hit = distance(UV, hit_points[i]);
        // 每個碰撞點產生一個局部遮罩
        float m = smoothstep(hit_intensities[i], hit_intensities[i] * 0.5, dist_to_hit);
        // 使用 max 或直接相加來合併遮罩
        total_hit_mask = max(total_hit_mask, m);
    }
    
    // 3. 能量擾動效果 (隨機感)
    float noise = sin(dist * 50.0 - TIME * 15.0) * 0.2;
    float final_brightness = (1.0 + noise) * 2.5;

    // 4. 輸出顏色
    float alpha = rim * total_hit_mask;
    COLOR = vec4(line_color.rgb, alpha * final_brightness * line_color.a);
}