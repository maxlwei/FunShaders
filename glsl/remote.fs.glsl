uniform int tvChannelU;

void main() {
	vec4 newColour = vec4(0.2, 0.2, 0.2, 1.0);
	if (tvChannelU == 1) {
		newColour = vec4(1.0, 0.0, 0.0, 1.0);
	} else if (tvChannelU == 2) {
		newColour = vec4(0.0, 1.0, 0.0, 1.0);
	} else {
		newColour = vec4(0.0, 0.0, 1.0, 1.0);
	}
	
	gl_FragColor = newColour;
}