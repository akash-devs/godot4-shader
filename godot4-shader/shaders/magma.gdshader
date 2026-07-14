shader_type spatial;
render_mode blend_mix, depth_draw_always, cull_back, unshaded;

uniform vec4 shield_color : source_color = vec4(0.0, 1.0, 0.4, 1.0);
uniform float pattern_scale : hint_range(1.0, 50.0) = 20.0;
uniform float pulse_speed : hint_range(0.0, 5.0) = 2.0;

void vertex() {
    // left empty, no billboarding junk!
}

void fragment() {
    // generate a 3D grid wrap by using vertex positions instead of flat UVs
    float grid = sin(VERTEX.x * pattern_scale) * sin(VERTEX.y * pattern_scale) * sin(VERTEX.z * pattern_scale);
    grid = smoothstep(0.0, 0.15, grid);
    
    float pulse = sin(TIME * pulse_speed) * 0.15 + 0.85;
    
    // clean procedural shading overlay
    vec3 final_color = shield_color.rgb * grid * pulse;
    
    ALBEDO = final_color;
    ALPHA = 1.0; // stays perfectly visible from any camera angle
}