// Create shared variable. The value is given as the interpolation between normals computed in the vertex shader
varying vec3 interpolatedNormal;
uniform vec3 remotePosition;
varying vec3 worldPosition;
uniform int tvChannelU;
uniform float frame;
uniform float radius;
/* HINT: YOU WILL NEED A DIFFERENT SHARED VARIABLE TO COLOR ACCORDING TO POSITION */

void main() {
  // Set final rendered color according to the surface normal
  gl_FragColor = vec4(normalize(interpolatedNormal), 1.0);
  
	
  
  if (distance(remotePosition, worldPosition) < radius) {
	gl_FragColor = vec4(normalize(reflect(interpolatedNormal, interpolatedNormal)),1.0);
  }
  
  if (tvChannelU == 1) {
	if (interpolatedNormal.y > 0.5) {
		gl_FragColor.x = (interpolatedNormal.y * 4.0) + gl_FragColor.x;
		gl_FragColor.y = (-interpolatedNormal.y / 5.0) + gl_FragColor.y;
		gl_FragColor.z = (-interpolatedNormal.y * 2.0) + gl_FragColor.z;
	}
  } else if (tvChannelU == 2) {
	gl_FragColor.y = (gl_FragColor.y / 5.0) + sin((distance(remotePosition, worldPosition) - (frame * 2.0)) * 2.0);
	if (distance(remotePosition, worldPosition) < 5.0) {
		gl_FragColor.x = gl_FragColor.x + ((5.0 - distance(remotePosition, worldPosition)) / 2.0);
		gl_FragColor.y = gl_FragColor.y + ((5.0 - distance(remotePosition, worldPosition)) / 2.0);
		gl_FragColor.z = gl_FragColor.z + ((5.0 - distance(remotePosition, worldPosition)) / 2.0);
	}
  } else if (tvChannelU == 3) {
	if (interpolatedNormal.y < - 0.5) {
		gl_FragColor.z = (-interpolatedNormal.y / 10.0) + gl_FragColor.z;
		gl_FragColor.x = (interpolatedNormal.y) + gl_FragColor.x;
		gl_FragColor.y = (interpolatedNormal.y) + gl_FragColor.y;
	}
  } 
}
