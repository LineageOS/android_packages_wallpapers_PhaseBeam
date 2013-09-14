varying float pointSize;
varying vec3 adjust;

// inspired by http://www.chilliant.com/rgb2hsv.html
vec3 hsl2rgb(vec3 hsl)
{
    float r = abs(hsl.x * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(hsl.x * 6.0 - 2.0);
    float b = 2.0 - abs(hsl.x * 6.0 - 4.0);
    vec3 rgb = clamp(vec3(r, g, b), 0.0, 1.0);
    float chroma = (1.0 - abs(2.0 * hsl.z - 1.0)) * hsl.y;
    return (rgb - 0.5) * chroma + hsl.z;
}

void main() {
    vec3 rgb = texture2D(UNI_Tex0, gl_PointCoord).rgb;

    if (adjust.x >= 0.0) {
        // rgb is already greyscale in that case, so r = g = b
        float value = max(rgb.r, max(rgb.g, rgb.b));
        vec3 hsl = adjust * vec3(1.0, 1.0, rgb.r);
        rgb = hsl2rgb(hsl);
    }

    // output pixel color
    gl_FragColor = vec4(rgb, pointSize);
}
