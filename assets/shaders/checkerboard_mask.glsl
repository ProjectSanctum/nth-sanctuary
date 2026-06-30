uniform float speed;
uniform Image pattern;

uniform vec2 offset;

// Adapted from https://github.com/jamieowen/glsl-blend/blob/master/color-burn.glsl
float blendColorBurn(float base, float blend) {
    return (blend==0.0)?blend:max((1.0-((1.0-base)/blend)),0.0);
}

vec3 blendColorBurn_vec3(vec3 base, vec3 blend) {
    return vec3(blendColorBurn(base.r,blend.r),blendColorBurn(base.g,blend.g),blendColorBurn(base.b,blend.b));
}

vec3 blendColorBurn_opacity(vec3 base, vec3 blend, float opacity) {
    return (blendColorBurn_vec3(base, blend) * opacity + base * (1.0 - opacity));
}


vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 texColor = Texel(texture, texture_coords);

    vec4 patternColor = Texel(pattern, mod(texture_coords+offset, vec2(1.0)));

    return vec4 (blendColorBurn_vec3(texColor.xyz, patternColor.xyz), texColor.a);
}