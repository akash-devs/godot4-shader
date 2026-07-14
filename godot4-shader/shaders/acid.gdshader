shader_type spatial;
render_mode blend_mix, depth_draw_always, cull_back, unshaded;

uniform vec4 rock_color : source_color = vec4(0.1, 0.04, 0.04, 1.0);
uniform vec4 lava_color : source_color = vec4(1.0, 0.25, 0.0, 1.0);
uniform float flow_speed : hint_range(0.0, 5.0) = 1.0;

float hash3D(vec3 p) {
    return fract(sin(dot(p, vec3(127.1, 311.7, 74.7))) * 43758.5453123);
}

float noise3D(vec3 p) {
    vec3 i = floor(p);
    vec3 p_fract = fract(p);
    vec3 u = p_fract * p_fract * (3.0 - 2.0 * p_fract);
    return mix(
        mix(mix(hash3D(i + vec3(0,0,0)), hash3D(i + vec3(1,0,0)), u.x),
            mix(hash3D(i + vec3(0,1,0)), hash3D(i + vec3(1,1,0)), u.x), u.y),
        mix(mix(hash3D(i + vec3(0,0,1)), hash3D(i + vec3(1,0,1)), u.x),
            mix(hash3D(i + vec3(0,1,1)), hash3D(i + vec3(1,1,1)), u.x), u.y), 
        u.z
    );
}

void vertex() {
    // no billboard hacks
}

void fragment() {
    vec3 w_pos = VERTEX * 6.0;
    
    // slow crawling 3D fluid movement
    vec3 movement = vec3(TIME * flow_speed * 0.1, TIME * flow_speed * 0.05, -TIME * flow_speed * 0.08);
    float lava_noise = noise3D(w_pos + movement);
    
    // crisp lines for molten cracks breaking through the crust
    float cracks = smoothstep(0.45, 0.55, lava_noise);
    
    vec3 final_surface = mix(rock_color.rgb, lava_color.rgb * 2.5, cracks);
    
    ALBEDO = final_surface;
    ALPHA = 1.0; // beautifully solid rock core
}