//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 uv_color;

void main()
{
	vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord);
	if (tex.a <= 0.0) discard;
	tex.rgb = uv_color.rgb;
	tex.a *= uv_color.a;
    gl_FragColor = tex;
}