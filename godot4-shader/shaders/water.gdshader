shader_type spatial;
// blend_mix and depth_draw_always keeps the sphere completely solid and visible
render_mode blend_mix, depth_draw_always, cull_back, unshaded;

uniform vec4 water_color : source_color = vec4(0.0, 0.4, 0.8, 1.0);
uniform vec4 foam_color : source_color = vec4(0.8, 0.95, 1.0, 1.0);
uniform float wave_speed : hint_range(0.0, 5.0) = 1.0;
uniform float wave_scale : hint_range(1.0, 20.0) = 5.0;

// simple random math helper for 3D noise
float hash3D(vec3 p) {
    return fract(sin(dot(p, vec3(127.1, 311.7, 74.7))) * 43758.5453123);
}

// 3D noise so it wraps around a sphere smoothly without cutting off
float noise3D(vec3 p) {
    vec3 i = floor(p);
    vec3 f = fract(p);
    vec3 u = f * f * (3.0 - 2.0 * f);
    
    return mix(
        mix(mix(hash3D(i + vec3(0,0,0)), hash3D(i + vec3(1,0,0)), u.x),
            mix(hash3D(i + vec3(0,1,0)), hash3D(i + vec3(1,1,0)), u.x), u.y),
        mix(mix(hash3D(i + vec3(0,0,1)), hash3D(i + vec3(1,0,1)), u.x),
            mix(hash3D(i + vec3(0,1,1)), hash3D(i + vec3(1,1,1)), u.x), u.y), 
        u.z
    );
}

void vertex() {
    // Left empty! Removing the billboard matrix stops it from getting flat and glitchy
}

void fragment() {
    // Use the 3D vertex position instead of flat 2D UV maps
    vec3 w_pos = VERTEX * wave_scale;
    
    // animate time for the flowing waves
    float t = TIME * wave_speed;
    
    // blend two 3D noise fields moving in different directions for organic water motion
    float noise1 = noise3D(w_pos + vec3(t, t * 0.2, -t * 0.3));
    float noise2 = noise3D(w_pos * 1.5 - vec3(-t * 0.2, t, t * 0.5));
    float combined_noise = (noise1 + noise2) * 0.5;
    
    // strict step lines to create the crisp cartoon stylized water foam
    float foam_lines = smoothstep(0.53, 0.56, combined_noise);
    
    // mix our base color and foam color
    vec3 final_color = mix(water_color.rgb, foam_color.rgb, foam_lines);
    
    ALBEDO = final_color;
    ALPHA = water_color.a; // keeping alpha completely solid
}