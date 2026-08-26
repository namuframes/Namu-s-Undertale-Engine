//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 texelSize;

float size = 1.0;

void main()
{
    float alpha = 0.0;
	float base = texture2D( gm_BaseTexture, v_vTexcoord).a;
    //Add alpha depending on the pixels surround it
	if (base <= 0.0) {
		vec2 offset = texelSize;
		alpha += texture2D( gm_BaseTexture, v_vTexcoord + vec2(-offset.x, 0.0) ).a;
		alpha += texture2D( gm_BaseTexture, v_vTexcoord + vec2(offset.x , 0.0) ).a;
		alpha += texture2D( gm_BaseTexture, v_vTexcoord + vec2(0.0, offset.y) ).a;
		alpha += texture2D( gm_BaseTexture, v_vTexcoord + vec2(0.0, -offset.y) ).a;
		
		alpha += texture2D( gm_BaseTexture, v_vTexcoord + vec2(-offset.x, -offset.y) ).a;
		alpha += texture2D( gm_BaseTexture, v_vTexcoord + vec2(offset.x ,offset.y) ).a;
		alpha += texture2D( gm_BaseTexture, v_vTexcoord + vec2(-offset.x, offset.y) ).a;
		alpha += texture2D( gm_BaseTexture, v_vTexcoord + vec2(offset.x, -offset.y) ).a;
	}
   
    gl_FragColor = vec4(1.0,0,0, alpha);
}

