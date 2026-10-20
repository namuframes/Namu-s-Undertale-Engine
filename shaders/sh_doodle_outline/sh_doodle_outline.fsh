varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 texelSize;
uniform vec3 color;
uniform float thickness;

const bool squarify = true;
const float TAU = 6.28318530718;

void main() {
	vec4 end_pixel = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );

	if ( texture2D( gm_BaseTexture, v_vTexcoord ).a <= 0.0 ) {
		float alpha = 0.0;

		if (squarify) {
			for ( int dx = -32; dx <= 32; dx++ ) {
				if ( abs(float(dx)) > thickness ) continue;

				for ( int dy = -32; dy <= 32; dy++ ) {
					if ( abs(float(dy)) > thickness ) continue;

					vec2 offset = vec2( float(dx), float(dy) ) * texelSize;
					alpha = max( alpha, texture2D( gm_BaseTexture, v_vTexcoord + offset ).a );
				}
			}
		} else {
			for ( int r = 1; r <= 32; r++ ) {
				if ( float(r) > thickness ) continue;

				float dirs = 4.0 * float(r);

				for ( int i = 0; i < 128; i++ ) {
					if ( float(i) >= dirs ) continue;

					float a = TAU * float(i) / dirs;
					vec2 d = vec2( cos(a), sin(a) );

					vec2 offset = floor( d * float(r) + 0.5 ) * texelSize;
					alpha = max( alpha, texture2D( gm_BaseTexture, v_vTexcoord + offset ).a );
				}
			}
		}

		end_pixel = vec4( color.r, color.g, color.b, alpha );
	}
	gl_FragColor = end_pixel;
}