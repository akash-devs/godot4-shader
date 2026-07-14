shader_type spatial;
// blend_mix and depth_draw_always keeps it a completely solid 3D sphere
render_mode blend_mix, depth_draw_always, cull_back, unshaded;

uniform vec4 plasma_color : source_color = vec4(0.1, 0.3, 0.8, 1.0);
uniform vec4 flash_color : source_color = vec4(0.8, 0.95, 1.0, 1.0);
uniform float lightning_speed : hint_range(0.0, 10.0) = 4.0;
uniform float bolt_thickness : hint_range(0.01, 0.2) = 0.05;

float hash3D(vec3 p) {
    return fract(sin(dot(p, vec3(127.1, 311.7, 74.7))) * 43758.5453123);
}

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
    // jitter vertex offset using 3D noise so the actual mesh surface shakes
    float jitter = noise3D(VERTEX * 10.0 + vec3(TIME * 15.0)) * 0.03;
    VERTEX += NORMAL * jitter;
}

void fragment() {
    vec3 w_pos = VERTEX * 4.0;
    float t = TIME * lightning_speed;
    
    // generate electrical tracks around the 3D surface
    float pattern = noise3D(w_pos + vec3(t, -t * 0.5, t * 0.2));
    pattern += 0.5 * noise3D(w_pos * 2.0 - vec3(t * 0.2, t, -t * 0.4));
    
    // creating sharp electrical arcs on the surface
    float arcs = abs(pattern - 0.5);
    float sparks = smoothstep(bolt_thickness, 0.0, arcs);
    
    // blend a solid energy base with glowing lightning streaks
    vec3 final_color = mix(plasma_color.rgb, flash_color.rgb, sparks * 2.0);
    
    ALBEDO = final_color;
    ALPHA = 1.0; // fully solid sphere
}