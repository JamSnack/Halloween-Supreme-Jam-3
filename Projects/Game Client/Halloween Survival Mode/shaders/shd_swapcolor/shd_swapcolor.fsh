//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 shirt_light;
uniform vec3 shirt_dark;
uniform vec3 pants_light;
uniform vec3 pants_dark;
uniform vec3 skin_light;
uniform vec3 skin_dark;

void main()
{
	vec4 base_color = texture2D(gm_BaseTexture, v_vTexcoord);
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
