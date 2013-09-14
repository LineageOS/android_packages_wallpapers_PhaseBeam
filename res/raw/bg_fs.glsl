varying lowp vec4 color;
varying vec3 adjust;

// http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
    vec3 rgb = color.rgb;

    if (adjust.x >= 0.0) {
        // rgb is already greyscale in that case
        float value = max(rgb.r, max(rgb.g, rgb.b));
        vec3 hsv = adjust * vec3(1.0, 1.0, value);
        rgb = hsv2rgb(hsv);
    }

    // output pixel color
    gl_FragColor = vec4(rgb, color.a);
}
