//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
 
uniform vec3 defaultPalette[3]; //An array containing a list of default colors
uniform vec3 newPalette[3]; //An array containing a list of 3 colors
 
vec4 recolorPixel(vec4 pixel) {
	
	//Here we are finding the difference between pixel and an index in our array.
	//If Alpha is less than 0.1, we know we have two identical colors and can make a swap!
	vec4 delta0 = abs(pixel - defaultPalette[0]); //First color in our default colors to change
	vec4 delta1 = abs(pixel - defaultPalette[1]); //Second color
	vec4 delta2 = abs(pixel - defaultPalette[2]); //Third color
 
	int colorChoice = 0;
	
	//Color checking
	if (length(delta0) < 0.1) {
		colorChoice = 0;
	} else if (length(delta1) < 0.1) {
		colorChoice = 1;
	} else if (length(delta2) < 0.1) {
		colorChoice = 2;

	if (colorChoice < 0) {
		colorChoice = 0;
	} else if (colorChoice > 2) {
		colorChoice = 2;
	}
	
	return newPalette[colorChoice];
}
 
void main()
{
	vec4 pixel =  texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = recolorPixel(pixel);
}