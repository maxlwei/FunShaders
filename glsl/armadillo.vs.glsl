// Create shared variable for the vertex and fragment shaders
varying vec3 interpolatedNormal;
varying vec3 worldPosition;
uniform vec3 remotePosition;
uniform int tvChannelU;
uniform float frame;
#define M_PI 3.1415926535897932384626433832795
/* HINT: YOU WILL NEED A DIFFERENT SHARED VARIABLE TO COLOR ACCORDING TO POSITION */

void main() {
    // Set shared variable to vertex normal
    interpolatedNormal = normal;
	
	vec3 newPosition = position;
	
	float sinDisplacement = sin(mod((frame * 4.0) + (newPosition.x * 100.0), M_PI / 2.0));
	float randomDisplacement = sin(mod((frame / 15.0) + (newPosition.x * 100.0), M_PI / 2.0));
	float windDisplacementz =  sin(mod(frame + (newPosition.z * 2.0), M_PI * 2.0));
	float windDisplacementx =  sin(mod(frame + (newPosition.x * 2.0) + 0.53, M_PI * 2.0));
	
	float waveDisplacement = sin((distance(remotePosition, vec3(modelMatrix * vec4(newPosition, 1.0))) - (frame * 2.0)) * 2.0);
	
	if (tvChannelU == 1) {
		if (normal.y > 0.6) {
			newPosition.y = (normal.y * sinDisplacement) + newPosition.y;
			
			float flameDisplacementz =  sin(mod((frame * 4.0) + (newPosition.y * 9.0), M_PI * 2.0));
			float flameDisplacementx =  sin(mod((frame * 5.0) + (newPosition.y * 4.0) + (newPosition.x * 4.0) + 0.53, M_PI * 2.0));
			newPosition.z = ((flameDisplacementz / 15.0) * (normal.y / 2.0)) + newPosition.z;
			newPosition.x = ((flameDisplacementx / 7.0) * (normal.y / 2.0)) + newPosition.x;
		}
	} else if (tvChannelU == 2) {
		if (waveDisplacement < 0.0) {
			waveDisplacement = 0.0;
		}
		newPosition = newPosition + ((normal * waveDisplacement) / 30.0);
	} else if (tvChannelU == 3) {
		if (normal.y < - 0.5) {
			newPosition.y = (normal.y * randomDisplacement) + newPosition.y;
			newPosition.z = ((windDisplacementz / 7.0) * (normal.y / 2.0)) + newPosition.z;
			newPosition.x = ((windDisplacementx / 7.0) * (normal.y / 2.0)) + newPosition.x;
		}
		if (newPosition.y < -1.05) {
			newPosition.y = -1.05;
		}
	}
	
	
	// set original position
	worldPosition = vec3(modelMatrix * vec4(newPosition, 1.0));
	
    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
    gl_Position = projectionMatrix * (viewMatrix * (modelMatrix * vec4(newPosition, 1.0)));
}
