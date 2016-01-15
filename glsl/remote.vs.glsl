// The uniform variable is set up in the javascript code and the same for all vertices
uniform vec3 remotePosition;

void main() {
	/* HINT: WORK WITH remotePosition HERE! */
	vec3 newRemotePosition = vec3(modelMatrix * vec4(remotePosition, 1.0));
    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
    gl_Position = projectionMatrix * (viewMatrix * vec4(position + newRemotePosition, 1.0));
}
