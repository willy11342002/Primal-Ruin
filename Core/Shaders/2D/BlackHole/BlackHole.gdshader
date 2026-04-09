shader_type canvas_item;

uniform bool _ShowDebugColors = false;
uniform sampler2D _ScreenTex : source_color, hint_screen_texture, repeat_disable;
uniform float _DistortionStrenght = 0.9;
uniform float _Attenuation = 10.0;
// 新增：半徑參數 (0.0 到 0.5 之間，因為 UV 中心到邊緣是 0.5)
uniform float _Radius : hint_range(0.0, 0.5) = 0.4;
// 新增：邊緣羽化，讓扭曲過渡更自然
uniform float _Feather : hint_range(0.0, 0.2) = 0.05;

void fragment() {
    // 1. 計算 UV 距離中心的向量與距離
    vec2 dir = (UV - vec2(0.5));
    float dist = length(dir);

    // 2. 建立範圍遮罩 (Mask)
    // 使用 smoothstep 讓邊界平滑過渡，如果不需要羽化可以將 _Feather 設為 0
    float mask = 1.0 - smoothstep(_Radius - _Feather, _Radius, dist);

    // 3. 計算扭曲向量
    vec2 distortion = dir;
    // 根據距離增加扭曲
    distortion *= pow(dist, -_DistortionStrenght);
    // 使用衰減讓邊緣效果減弱
    distortion *= pow((1.0 - dist), _Attenuation);
    
    // 4. 關鍵修改：將扭曲向量乘以遮罩
    // 當 dist > _Radius 時，mask 會變成 0，扭曲位移就會歸零
    vec2 final_offset = distortion * mask;

    // 5. 應用到螢幕紋理
    COLOR = vec4(texture(_ScreenTex, SCREEN_UV - final_offset).rgb, 1.0);

    // Debug 模式下視覺化遮罩範圍
    if (_ShowDebugColors) {
        COLOR = vec4(vec3(mask), 1.0);
    }
}