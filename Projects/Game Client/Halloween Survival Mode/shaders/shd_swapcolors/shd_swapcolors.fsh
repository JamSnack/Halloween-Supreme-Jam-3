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

uniform vec3 replace_shirt_light;
uniform vec3 replace_shirt_dark;
uniform vec3 replace_pants_light;
uniform vec3 replace_pants_dark;
uniform vec3 replace_skin_light;
uniform vec3 replace_skin_dark;

void main()
{    
    vec4 pixel = texture2D(gm_BaseTexture, v_vTexcoord);    
    vec3 eps = vec3(0.009, 0.009, 0.009);

    // SHIRTS
	if( all( greaterThanEqual(pixel, vec4(shirt_light - eps, 1.0)) ) && all( lessThanEqual(pixel, vec4(shirt_light + eps, 1.0)) ) )        
        pixel = vec4(replace_shirt_light, 1.0);
			
	if( all( greaterThanEqual(pixel, vec4(shirt_dark - eps, 1.0)) ) && all( lessThanEqual(pixel, vec4(shirt_dark + eps, 1.0)) ) )        
	    pixel = vec4(replace_shirt_dark, 1.0);    

    //Pixel of color 2? Different in all cases?
    /*if( all( greaterThanEqual(pixel, vec4(color2 - eps, 1.0)) ) && all( lessThanEqual(pixel, vec4(color2 + eps, 1.0)) ) )        
        pixel = vec4(replace2, 1.0);   */ 


    gl_FragColor = pixel;
}
