varying vec2 v_uv;
varying float v_alpha;

void main()
{
    vec4 col = texture2D(gm_BaseTexture, v_uv);
    col.a *= v_alpha;
    gl_FragColor = col;
}