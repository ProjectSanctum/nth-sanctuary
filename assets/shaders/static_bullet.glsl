uniform float time;
uniform float brightness;
vec3 random3(vec3 c) {
    float j = 4096.0 * sin(dot(c, vec3(17.0, 59.4, 15.0)));
    vec3 r;
    r.z = fract(512.0 * j);
    j *= 0.125;
    r.x = fract(512.0 * j);
    j *= 0.125;
    r.y = fract(512.0 * j);
    return r - 0.5;
}
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 texColor = Texel(texture, texture_coords);
    // If the alpha is below a threshold (e.g., 0.01), return the original color
    if (texColor.a < 0.01) {
        return texColor * color;
    }
    // If the color is black (or close to black), return the original color
    if (length(texColor.rgb) < 0.01) {
        return texColor * color;
    }
    vec3 pos = vec3(screen_coords.xy, floor(time * 15.0));
    float n = random3(pos).r;
    vec3 noise = vec3(n, n, n);
    // Increase brightness and clamp values to [0, 1]
    noise = clamp(noise * brightness + 0.75, 0.0, 1.0);
    return vec4(noise, 1.0) * color * texColor.a;
}