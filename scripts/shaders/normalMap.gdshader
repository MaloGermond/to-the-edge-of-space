shader_type canvas_item;

// Normal map
uniform sampler2D normal_map : source_color, filter_linear_mipmap;
uniform float normal_strength : hint_range(0.0, 2.0) = 1.0;

// Couleur et direction de la lumière (doivent être des uniforms)
uniform vec3 light_color : source_color = vec3(1.0, 1.0, 1.0);
uniform vec3 light_dir : source_color = vec3(0.5, 0.5, 1.0);

void fragment() {
    vec3 normal = texture(normal_map, UV).xyz * 2.0 - 1.0;
    normal.xy *= normal_strength;
    normal = normalize(normal);

    float lighting = dot(normal, normalize(light_dir));
    lighting = clamp(lighting, 0.0, 1.0);

    COLOR.rgb = light_color * lighting;
    COLOR.a = lighting;
}
